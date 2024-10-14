import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:shopingly/features/authentication/screens/signup/signup.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';

class ShopinglyLoginForm extends StatelessWidget {
  const ShopinglyLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: ShopinglySizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: ShopinglyTexts.email),
            ),
            const SizedBox(
              height: ShopinglySizes.spaceBtwInputFields,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: ShopinglyTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(
              height: ShopinglySizes.spaceBtwInputFields / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(ShopinglyTexts.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => ForgetPassword()),
                  child: const Text(ShopinglyTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(
              height: ShopinglySizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(ShopinglyTexts.signIn),
              ),
            ),
            SizedBox(
              height: ShopinglySizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(()=> SignupScreen()),
                child: Text(ShopinglyTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}