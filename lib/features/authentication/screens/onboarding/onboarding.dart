import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:shopingly/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:shopingly/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:shopingly/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:shopingly/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: ShopinglyImages.onBoardingImage1,
                title: ShopinglyTexts.onBoardingTitle1,
                subTitle: ShopinglyTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: ShopinglyImages.onBoardingImage2,
                title: ShopinglyTexts.onBoardingTitle2,
                subTitle: ShopinglyTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: ShopinglyImages.onBoardingImage3,
                title: ShopinglyTexts.onBoardingTitle3,
                subTitle: ShopinglyTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          /// Skip Button
          OnBoardingSkip(),

          /// Dot Navigation smoothPageIndicator
          OnBoardingDotNavigation(),

          /// Circular button
          OnBoardingNextButton(),
        ],
      ),
    );
  }
}


