import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/authentication/controllers/signup/signup_controller.dart';
import 'package:shopingly/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/validators/validation.dart';

class ShopinglySignupForm extends StatefulWidget {
  const ShopinglySignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  State<ShopinglySignupForm> createState() => _ShopinglySignupFormState();
}

class _ShopinglySignupFormState extends State<ShopinglySignupForm> {
  // Unique tag: each sign-up screen gets its own controller (see the login form).
  late final controller =
      Get.put(SignupController(), tag: UniqueKey().toString());

  @override
  Widget build(BuildContext context) {
    final dark = widget.dark;
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// First & Last names
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      ShopinglyValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ShopinglyTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(
                width: ShopinglySizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      ShopinglyValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ShopinglyTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ShopinglySizes.spaceBtwInputFields,
          ),

          /// User name
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                ShopinglyValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: ShopinglyTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          SizedBox(
            height: ShopinglySizes.spaceBtwInputFields,
          ),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: ShopinglyValidator.validateEmail,
            keyboardType: TextInputType.emailAddress,
            expands: false,
            decoration: const InputDecoration(
              labelText: ShopinglyTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          SizedBox(
            height: ShopinglySizes.spaceBtwInputFields,
          ),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: ShopinglyValidator.validatePhoneNumber,
            keyboardType: TextInputType.phone,
            expands: false,
            decoration: const InputDecoration(
              labelText: ShopinglyTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          SizedBox(
            height: ShopinglySizes.spaceBtwInputFields,
          ),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: ShopinglyValidator.validatePassword,
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: ShopinglyTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.toggle(),
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          SizedBox(
            height: ShopinglySizes.spaceBtwInputFields,
          ),

          /// Terms and Conditions checkbox
          ShopinglyTermsAndConditionsCheckbox(
              dark: dark, controller: controller),
          SizedBox(
            height: ShopinglySizes.spaceBtwSections,
          ),

          /// Signup button
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.signup,
                child: controller.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(ShopinglyTexts.createAccount),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
