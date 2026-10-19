import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/authentication/controllers/login/login_controller.dart';
import 'package:shopingly/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:shopingly/features/authentication/screens/signup/signup.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/validators/validation.dart';

class ShopinglyLoginForm extends StatefulWidget {
  const ShopinglyLoginForm({
    super.key,
  });

  @override
  State<ShopinglyLoginForm> createState() => _ShopinglyLoginFormState();
}

class _ShopinglyLoginFormState extends State<ShopinglyLoginForm> {
  // A unique tag gives every login screen its own controller. Without it GetX hands a new
  // screen the previous screen's controller, then disposes it when the old route is removed.
  late final controller =
      Get.put(LoginController(), tag: UniqueKey().toString());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: ShopinglySizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: ShopinglyValidator.validateEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: ShopinglyTexts.email),
            ),
            const SizedBox(
              height: ShopinglySizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    ShopinglyValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                onFieldSubmitted: (_) => controller.login(),
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: ShopinglyTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.toggle(),
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
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
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) =>
                            controller.rememberMe.value = value ?? false,
                      ),
                    ),
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
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.login,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(ShopinglyTexts.signIn),
                ),
              ),
            ),
            SizedBox(
              height: ShopinglySizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => SignupScreen()),
                child: Text(ShopinglyTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
