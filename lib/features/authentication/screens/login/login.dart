import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/styles/spacing_styles.dart';
import 'package:shopingly/common/widgets/login_signup/shopingly_form_divider.dart';
import 'package:shopingly/common/widgets/login_signup/shopingly_social_buttons.dart';
import 'package:shopingly/features/authentication/screens/login/widgets/shopingly_login_form.dart';
import 'package:shopingly/features/authentication/screens/login/widgets/shopingly_login_header.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ShopinglySpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, title & subtitle
              ShopinglyLoginHeader(dark: dark),

              /// Form
              ShopinglyLoginForm(),

              /// Divider
              ShopinglyFormDivider(dark: dark, dividerText: ShopinglyTexts.orSignInWith.capitalize!),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),

              /// Footer
              ShopinglySocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


