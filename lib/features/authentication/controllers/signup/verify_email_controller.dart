import 'dart:async';

import 'package:get/get.dart';
import 'package:shopingly/common/widgets/success_screen/success_screen.dart';
import 'package:shopingly/data/repositories/authentication/authentication_repository.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final isLoading = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      try {
        if (await AuthenticationRepository.instance.reloadAndCheckEmailVerified()) {
          _showSuccess();
        }
      } catch (e) {
        ShopinglyLoggerHelper.debug('Email verification poll failed: $e');
      }
    });
  }

  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      ShopinglyLoaders.successSnackBar(
        title: 'Email sent',
        message: 'Please check your inbox and verify your email.',
      );
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not send verification email', e);
      ShopinglyLoaders.errorSnackBar(
          title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    }
  }

  Future<void> checkEmailVerificationStatus() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      if (await AuthenticationRepository.instance.reloadAndCheckEmailVerified()) {
        _showSuccess();
      } else {
        ShopinglyLoaders.warningSnackBar(
          title: 'Not verified yet',
          message: 'Open the link we emailed you, then try again.',
        );
      }
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not check verification status', e);
      ShopinglyLoaders.errorSnackBar(
          title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  void _showSuccess() {
    _timer?.cancel();
    Get.off(
      () => SuccessScreen(
        image: ShopinglyImages.staticSuccessIllustration,
        title: ShopinglyTexts.yourAccountCreatedTitle,
        subTitle: ShopinglyTexts.yourAccountCreatedSubTitle,
        onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      ),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
