import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/authentication/authentication_repository.dart';
import 'package:shopingly/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final forgetPasswordFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendPasswordResetEmail() async {
    if (isLoading.value) return;
    if (!forgetPasswordFormKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());
      ShopinglyLoaders.successSnackBar(
        title: 'Email sent',
        message: 'Check your inbox for the password reset link.',
      );
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      ShopinglyLoggerHelper.error('Password reset failed', e);
      ShopinglyLoaders.errorSnackBar(
          title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendPasswordResetEmail(String email) async {
    try {
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      ShopinglyLoaders.successSnackBar(
        title: 'Email sent',
        message: 'Check your inbox for the password reset link.',
      );
    } catch (e) {
      ShopinglyLoggerHelper.error('Password reset resend failed', e);
      ShopinglyLoaders.errorSnackBar(
          title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    }
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}
