import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/address/address_repository.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// The signed-in customer's saved shipping addresses.
class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final _repository = AddressRepository();

  final addresses = <AddressModel>[].obs;
  final isLoading = false.obs;

  StreamSubscription<User?>? _authSubscription;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// The address used for shipping, if the customer has one.
  AddressModel? get selected => addresses.firstWhereOrNull((a) => a.isSelected) ?? addresses.firstOrNull;

  @override
  void onInit() {
    super.onInit();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        addresses.clear();
      } else {
        fetch();
      }
    });
  }

  Future<void> fetch() async {
    final uid = _uid;
    if (uid == null) return;
    isLoading.value = true;
    try {
      addresses.assignAll(await _repository.fetch(uid));
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not load addresses', e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Saves a new address. The first one a customer adds becomes their shipping address.
  Future<bool> add(AddressModel draft) async {
    final uid = _uid;
    if (uid == null) return false;
    try {
      final id = await _repository.add(uid, draft);
      await fetch();
      if (addresses.length == 1 || draft.isSelected) await select(id);
      ShopinglyLoaders.successSnackBar(title: 'Address saved');
      return true;
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not save the address', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
      return false;
    }
  }

  Future<void> select(String id) async {
    final uid = _uid;
    if (uid == null) return;
    // Update the UI first so the tap feels instant, then persist.
    final previous = [...addresses];
    addresses.assignAll(addresses.map((a) => a.copyWith(isSelected: a.id == id)));
    try {
      await _repository.select(uid, id, previous);
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not change the shipping address', e);
      addresses.assignAll(previous);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    }
  }

  Future<void> delete(AddressModel address) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _repository.delete(uid, address.id);
      await fetch();
      if (address.isSelected && addresses.isNotEmpty) await select(addresses.first.id);
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not delete the address', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    }
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }
}
