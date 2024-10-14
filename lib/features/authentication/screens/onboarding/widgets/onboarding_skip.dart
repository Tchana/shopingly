import 'package:flutter/material.dart';
import 'package:shopingly/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ShopinglyDeviceUtils.getAppBarHeight(),
      right: ShopinglySizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: const Text(
          "Skip",
        ),
      ),
    );
  }
}