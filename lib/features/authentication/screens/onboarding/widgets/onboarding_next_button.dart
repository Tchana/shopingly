import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/device/device_utility.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Positioned(
      right: ShopinglySizes.defaultSpace,
      bottom: ShopinglyDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), backgroundColor: dark ? ShopinglyColors.primaryColor :  Colors.black),
        child: Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}