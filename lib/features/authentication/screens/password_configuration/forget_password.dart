import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/validators/validation.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              ShopinglyTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: ShopinglySizes.spaceBtwItems,
            ),
            Text(
              ShopinglyTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(
              height: ShopinglySizes.spaceBtwSections * 2,
            ),

            /// Text fields
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: ShopinglyValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (_) => controller.sendPasswordResetEmail(),
                decoration: InputDecoration(
                  labelText: ShopinglyTexts.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            SizedBox(
              height: ShopinglySizes.spaceBtwSections,
            ),

            /// Submit button
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.sendPasswordResetEmail,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(ShopinglyTexts.submit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
