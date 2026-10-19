import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/authentication/authentication_repository.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/local_storage/storage_utility.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  static const _rememberedEmailKey = 'REMEMBER_ME_EMAIL';

  final loginFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final _storage = ShopinglyLocalStorage();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Only the email is remembered; the password is never stored on the device.
    email.text = _storage.readData<String>(_rememberedEmailKey) ?? '';
    rememberMe.value = email.text.isNotEmpty;
  }

  Future<void> login() async {
    if (isLoading.value) return;
    if (!loginFormKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      if (rememberMe.value) {
        await _storage.saveData(_rememberedEmailKey, email.text.trim());
      } else {
        await _storage.removeData(_rememberedEmailKey);
      }

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text);
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      ShopinglyLoggerHelper.error('Login failed', e);
      ShopinglyLoaders.errorSnackBar(
          title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
