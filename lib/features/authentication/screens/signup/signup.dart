import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/login_signup/shopingly_form_divider.dart';
import 'package:shopingly/common/widgets/login_signup/shopingly_social_buttons.dart';
import 'package:shopingly/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ShopinglyTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),
              ShopinglySignupForm(dark: dark),
              SizedBox(height: ShopinglySizes.spaceBtwSections,),

              /// Divider
              ShopinglyFormDivider(dark: dark, dividerText: ShopinglyTexts.orSignUpWith.capitalize!),
              SizedBox(height: ShopinglySizes.spaceBtwSections,),

              /// Social buttons
              ShopinglySocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
