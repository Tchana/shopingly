import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopingly/features/authentication/screens/login/login.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(ShopinglyImages.deliveredEmailIllustration),
                width: ShopinglyHelperFunctions.screenWidth(),
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  email,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwItems,
              ),
              Text(
                ShopinglyTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              Text(
                ShopinglyTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.offAll(() => const LoginScreen()),
                    child: Text(ShopinglyTexts.done)),
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => ForgetPasswordController.instance
                        .resendPasswordResetEmail(email),
                    child: Text(ShopinglyTexts.resendEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
