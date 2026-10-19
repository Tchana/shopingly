import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/order/order_repository.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// The signed-in customer's order history.
class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final _repository = OrderRepository();

  final orders = <OrderModel>[].obs;
  final isLoading = false.obs;

  StreamSubscription<User?>? _authSubscription;

  @override
  void onInit() {
    super.onInit();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        orders.clear();
      } else {
        fetch();
      }
    });
  }

  Future<void> fetch() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    isLoading.value = true;
    try {
      orders.assignAll(await _repository.forUser(uid));
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not load orders', e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Cancels a pending order. Returns true on success.
  Future<bool> cancel(OrderModel order) async {
    try {
      await _repository.cancel(order.id);
      await fetch();
      ShopinglyLoaders.successSnackBar(title: 'Order cancelled', message: 'Order ${order.code} was cancelled.');
      return true;
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not cancel the order', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
      return false;
    }
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }
}
