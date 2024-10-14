import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/success_screen/success_screen.dart';
import 'package:shopingly/features/authentication/screens/login/login.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: AssetImage(ShopinglyImages.deliveredEmailIllustration),
                width: ShopinglyHelperFunctions.screenWidth(),
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              Text(
                ShopinglyTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              Text(
                'support@shopingly.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              Text(
                ShopinglyTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(
                    () => SuccessScreen(
                      image: ShopinglyImages.staticSuccessIllustration,
                      title: ShopinglyTexts.yourAccountCreatedTitle,
                      subTitle: ShopinglyTexts.yourAccountCreatedSubTitle,
                      onPressed: () => Get.to(() => LoginScreen()),
                    ),
                  ),
                  child: Text(ShopinglyTexts.continueText),
                ),
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(ShopinglyTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
