import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/authentication/authentication_repository.dart';
import 'package:shopingly/data/repositories/user/user_repository.dart';
import 'package:shopingly/features/authentication/screens/signup/verify_email.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/features/personalization/models/user_model.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final signupFormKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final isLoading = false.obs;

  Future<void> signup() async {
    if (isLoading.value) return;
    if (!signupFormKey.currentState!.validate()) return;

    if (!privacyPolicy.value) {
      ShopinglyLoaders.warningSnackBar(
        title: 'Accept Privacy Policy',
        message: 'You must accept the Privacy Policy and Terms of Use to create an account.',
      );
      return;
    }

    isLoading.value = true;
    try {
      final credential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text);

      // The account exists from here on, so failures below must not block the user.
      try {
        await AuthenticationRepository.instance.sendEmailVerification();
      } catch (e) {
        ShopinglyLoggerHelper.error('Could not send verification email', e);
      }

      try {
        await UserRepository.instance.saveUserRecord(UserModel(
          id: credential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
        ));
        await UserController.instance.fetchUserRecord();
      } catch (e) {
        ShopinglyLoggerHelper.error('Could not save user record', e);
        ShopinglyLoaders.warningSnackBar(
          title: 'Account created',
          message: "We couldn't save your profile details yet. You can add them later.",
        );
      }

      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      ShopinglyLoggerHelper.error('Signup failed', e);
      ShopinglyLoaders.errorSnackBar(
          title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.onClose();
  }
}
