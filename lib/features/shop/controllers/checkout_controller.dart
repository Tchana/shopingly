import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/success_screen/success_screen.dart';
import 'package:shopingly/data/repositories/catalog/catalog_repository.dart';
import 'package:shopingly/data/repositories/coupon/coupon_repository.dart';
import 'package:shopingly/data/repositories/order/order_repository.dart';
import 'package:shopingly/features/personalization/controllers/address_controller.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/controllers/order_controller.dart';
import 'package:shopingly/navigation_menu.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final _orders = OrderRepository();
  final _catalog = CatalogRepository();
  final _coupons = CouponRepository();

  final paymentMethod = PaymentMethod.cashOnDelivery.obs;
  final isPlacing = false.obs;

  /// Re-checks every line against the live catalog, then places the order.
  /// Prices and stock are read fresh from Firestore so a stale cart can never
  /// be ordered at an old price or for an item that sold out.
  Future<void> placeOrder() async {
    if (isPlacing.value) return;
    final cart = CartController.instance;
    final user = FirebaseAuth.instance.currentUser;
    final address = AddressController.instance.selected;

    if (user == null) return;
    if (cart.items.isEmpty) {
      ShopinglyLoaders.warningSnackBar(title: 'Your cart is empty', message: 'Add something before checking out.');
      return;
    }
    if (address == null) {
      ShopinglyLoaders.warningSnackBar(
        title: 'No shipping address',
        message: 'Add a shipping address so we know where to deliver.',
      );
      return;
    }

    isPlacing.value = true;
    try {
      // 1. Refresh the lines from the live products.
      final problems = <String>[];
      for (final item in [...cart.items]) {
        final live = await _catalog.product(item.productId);
        if (live == null || !live.inStock) {
          problems.add('${item.title} is no longer available.');
        } else if (item.quantity > live.stock) {
          problems.add('Only ${live.stock} of ${live.title} left.');
        } else if (item.price != live.effectivePrice) {
          problems.add('${live.title} changed price to ${CatalogController.instance.settings.value.money(live.effectivePrice)}.');
        }
      }
      if (problems.isNotEmpty) {
        await CatalogController.instance.load();
        cart.syncWithCatalog();
        ShopinglyLoaders.warningSnackBar(
          title: 'Your cart was updated',
          message: '${problems.join(' ')} Please review it and try again.',
        );
        return;
      }

      // 2. The coupon might have been switched off since it was applied.
      final applied = cart.coupon.value;
      if (applied != null) {
        final fresh = await _coupons.byCode(applied.code);
        if (fresh == null || fresh.validate(cart.subtotal) != null) {
          cart.removeCoupon();
          ShopinglyLoaders.warningSnackBar(
            title: 'Promo code removed',
            message: 'The code ${applied.code} is no longer valid. Please review your total.',
          );
          return;
        }
        cart.coupon.value = fresh;
      }

      // 3. Place the order.
      final totals = cart.totals;
      final profile = UserController.instance.user.value;
      final order = OrderModel(
        id: '',
        userId: user.uid,
        customerName: profile.fullName.isEmpty ? (user.displayName ?? '') : profile.fullName,
        customerEmail: user.email ?? profile.email,
        paymentMethod: paymentMethod.value,
        items: cart.items.map((i) => i.toOrderItem()).toList(),
        address: address,
        subtotal: totals.subtotal,
        discount: totals.discount,
        shipping: totals.shipping,
        tax: totals.tax,
        total: totals.total,
        couponCode: cart.coupon.value?.code ?? '',
      );
      final id = await _orders.place(order);

      cart.clear();
      OrderController.instance.fetch();
      final code = OrderModel.fromMap(id, const {}).code;
      Get.offAll(
        () => SuccessScreen(
          image: ShopinglyImages.successfulPaymentIcon,
          title: 'Order placed!',
          subTitle: 'Your order $code is on its way to being processed. You can follow it under My Orders.',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      ShopinglyLoggerHelper.error('Placing the order failed', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    } finally {
      isPlacing.value = false;
    }
  }
}
