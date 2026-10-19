import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/authentication/authentication_repository.dart';
import 'package:shopingly/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
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
                email ?? '',
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
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.checkEmailVerificationStatus,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(ShopinglyTexts.continueText),
                  ),
                ),
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: controller.sendEmailVerification,
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
