import 'package:flutter/material.dart';
import 'package:shopingly/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/device/device_utility.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = ShopinglyHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: ShopinglyDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: ShopinglySizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? ShopinglyColors.light : ShopinglyColors.dark,
          dotHeight: 6,
        ),
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
      ),
    );
  }
}