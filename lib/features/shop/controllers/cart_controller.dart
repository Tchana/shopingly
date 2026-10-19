import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopingly/data/repositories/coupon/coupon_repository.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/models/cart_item_model.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// The shopping cart. Saved on the device per signed-in user, so one person's
/// cart never leaks into another's.
class CartController extends GetxController {
  static CartController get instance => Get.find();

  final _storage = GetStorage();
  final _coupons = CouponRepository();

  final items = <CartItemModel>[].obs;
  final coupon = Rxn<CouponModel>();
  final isApplyingCoupon = false.obs;

  StreamSubscription<User?>? _authSubscription;
  String? _uid;

  String get _storageKey => 'cart_$_uid';

  @override
  void onInit() {
    super.onInit();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      _uid = user?.uid;
      coupon.value = null;
      _load();
    });
  }

  // ---- Totals
  int get count => items.fold(0, (total, i) => total + i.quantity);

  double get subtotal => roundMoney(items.fold(0.0, (total, i) => total + i.lineTotal));

  /// The coupon's discount, or 0 if the cart no longer qualifies for it.
  double get discount {
    final c = coupon.value;
    if (c == null || c.validate(subtotal) != null) return 0;
    return c.discountFor(subtotal);
  }

  OrderTotals get totals => OrderTotals.compute(
        subtotal: subtotal,
        settings: CatalogController.instance.settings.value,
        discount: discount,
      );

  // ---- Editing
  /// Adds [quantity] of [product]. Returns false (and tells the customer) if the stock cannot cover it.
  bool add(ProductModel product, {int quantity = 1, Map<String, String> attributes = const {}}) {
    if (!product.inStock) {
      ShopinglyLoaders.warningSnackBar(title: 'Out of stock', message: '${product.title} is currently unavailable.');
      return false;
    }
    final candidate = CartItemModel(
      productId: product.id,
      title: product.title,
      image: product.thumbnail,
      brandName: product.brandName,
      price: product.effectivePrice,
      quantity: quantity,
      attributes: attributes,
    );
    final index = items.indexWhere((i) => i.key == candidate.key);
    final alreadyInCart = index >= 0 ? items[index].quantity : 0;
    if (alreadyInCart + quantity > product.stock) {
      ShopinglyLoaders.warningSnackBar(
        title: 'Not enough stock',
        message: 'Only ${product.stock} of ${product.title} available.',
      );
      return false;
    }
    if (index >= 0) {
      items[index].quantity += quantity;
      items.refresh();
    } else {
      items.add(candidate);
    }
    _save();
    return true;
  }

  void increment(CartItemModel item) {
    final product = CatalogController.instance.productById(item.productId);
    if (product != null && item.quantity + 1 > product.stock) {
      ShopinglyLoaders.warningSnackBar(title: 'Not enough stock', message: 'Only ${product.stock} available.');
      return;
    }
    item.quantity++;
    items.refresh();
    _save();
  }

  void decrement(CartItemModel item) {
    if (item.quantity <= 1) {
      remove(item);
      return;
    }
    item.quantity--;
    items.refresh();
    _save();
  }

  void remove(CartItemModel item) {
    items.removeWhere((i) => i.key == item.key);
    _save();
  }

  void clear() {
    items.clear();
    coupon.value = null;
    _save();
  }

  // ---- Coupons
  Future<void> applyCoupon(String code) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) return;
    isApplyingCoupon.value = true;
    try {
      final found = await _coupons.byCode(trimmed);
      if (found == null) {
        ShopinglyLoaders.errorSnackBar(title: 'Invalid code', message: 'We could not find that promo code.');
        return;
      }
      final problem = found.validate(subtotal);
      if (problem != null) {
        ShopinglyLoaders.warningSnackBar(title: 'Cannot apply code', message: problem);
        return;
      }
      coupon.value = found;
      ShopinglyLoaders.successSnackBar(title: 'Code applied', message: '${found.code}: ${found.label}');
    } catch (e) {
      ShopinglyLoggerHelper.error('Applying a coupon failed', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    } finally {
      isApplyingCoupon.value = false;
    }
  }

  void removeCoupon() => coupon.value = null;

  // ---- Keeping the cart honest
  /// Brings prices, titles and stock in line with the latest catalog. Lines for
  /// products that were removed or sold out are dropped; returns what changed so
  /// the customer can be told.
  List<String> syncWithCatalog() {
    final catalog = CatalogController.instance;
    final notes = <String>[];
    for (final item in [...items]) {
      final product = catalog.productById(item.productId);
      if (product == null || !product.inStock) {
        items.removeWhere((i) => i.key == item.key);
        notes.add('${item.title} is no longer available and was removed.');
        continue;
      }
      if (item.price != product.effectivePrice) {
        notes.add('${product.title} is now ${catalog.settings.value.money(product.effectivePrice)}.');
        item.price = product.effectivePrice;
      }
      if (item.quantity > product.stock) {
        item.quantity = product.stock;
        notes.add('Only ${product.stock} of ${product.title} left; quantity reduced.');
      }
      item.title = product.title;
      item.image = product.thumbnail;
      item.brandName = product.brandName;
    }
    if (notes.isNotEmpty) {
      items.refresh();
      _save();
    }
    return notes;
  }

  // ---- Persistence
  void _load() {
    if (_uid == null) {
      items.clear();
      return;
    }
    try {
      final raw = _storage.read<String>(_storageKey);
      if (raw == null) {
        items.clear();
        return;
      }
      final list = (jsonDecode(raw) as List).map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e as Map)));
      items.assignAll(list);
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not read the saved cart', e);
      items.clear();
    }
  }

  void _save() {
    if (_uid == null) return;
    _storage.write(_storageKey, jsonEncode(items.map((i) => i.toJson()).toList()));
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }
}
