import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// Products the customer has hearted. Saved on the device per signed-in user.
class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final _storage = GetStorage();
  final ids = <String>{}.obs;

  StreamSubscription<User?>? _authSubscription;
  String? _uid;

  String get _storageKey => 'wishlist_$_uid';

  @override
  void onInit() {
    super.onInit();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      _uid = user?.uid;
      final saved = _uid == null ? null : _storage.read<List>(_storageKey);
      ids.assignAll(saved?.map((e) => e.toString()) ?? const <String>[]);
    });
  }

  bool isFavourite(String productId) => ids.contains(productId);

  void toggle(String productId) {
    if (!ids.remove(productId)) ids.add(productId);
    if (_uid != null) _storage.write(_storageKey, ids.toList());
  }

  /// Wishlisted products that still exist in the catalog.
  List<ProductModel> get products {
    final catalog = CatalogController.instance;
    return ids.map(catalog.productById).whereType<ProductModel>().toList();
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }
}
