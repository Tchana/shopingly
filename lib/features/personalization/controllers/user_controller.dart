import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopingly/data/repositories/user/user_repository.dart';
import 'package:shopingly/features/personalization/models/user_model.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';

/// Holds the signed-in user's profile. Lives for the whole app session and follows
/// sign-in / sign-out so it never shows a previous user's data.
class UserController extends GetxController {
  static UserController get instance => Get.find();

  final user = UserModel.empty.obs;
  final profileLoading = false.obs;

  StreamSubscription<User?>? _authSubscription;

  @override
  void onInit() {
    super.onInit();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((authUser) {
      if (authUser == null) {
        user.value = UserModel.empty;
      } else {
        fetchUserRecord();
      }
    });
  }

  Future<void> fetchUserRecord() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    profileLoading.value = true;
    try {
      final fetched = await UserRepository.instance.fetchUserDetails(uid);
      // Ignore the result if the user signed out while the request was in flight.
      if (FirebaseAuth.instance.currentUser?.uid == uid) user.value = fetched;
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not fetch user record', e);
    } finally {
      profileLoading.value = false;
    }
  }

  /// Saves edits to the customer's name, username and phone number.
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String username,
    required String phoneNumber,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return false;
    try {
      final fields = {
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'username': username.trim(),
        'phoneNumber': phoneNumber.trim(),
      };
      await UserRepository.instance.updateUserFields(uid, fields);
      user.value = user.value.copyWith(
        firstName: fields['firstName'],
        lastName: fields['lastName'],
        username: fields['username'],
        phoneNumber: fields['phoneNumber'],
      );
      ShopinglyLoaders.successSnackBar(title: 'Profile updated');
      return true;
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not update the profile', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
      return false;
    }
  }

  /// Permanently deletes the account. Firebase requires a recent sign-in for this,
  /// so the customer's password is confirmed first.
  Future<bool> deleteAccount(String password) async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null || authUser.email == null) return false;
    try {
      await authUser.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: authUser.email!, password: password),
      );
      await UserRepository.instance.deleteUserData(authUser.uid);
      final storage = GetStorage();
      await storage.remove('cart_${authUser.uid}');
      await storage.remove('wishlist_${authUser.uid}');
      await authUser.delete();
      return true;
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not delete the account', e);
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
