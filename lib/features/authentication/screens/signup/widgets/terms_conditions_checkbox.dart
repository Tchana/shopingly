import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';

class ShopinglyTermsAndConditionsCheckbox extends StatelessWidget {
  const ShopinglyTermsAndConditionsCheckbox({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          width: ShopinglySizes.spaceBtwItems,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: '${ShopinglyTexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: ShopinglyTexts.privacyPolicy,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark
                        ? ShopinglyColors.white
                        : ShopinglyColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? ShopinglyColors.white
                        : ShopinglyColors.primaryColor,
                  ),
            ),
            TextSpan(
              text: ' ${ShopinglyTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: ShopinglyTexts.termsOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark
                        ? ShopinglyColors.white
                        : ShopinglyColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? ShopinglyColors.white
                        : ShopinglyColors.primaryColor,
                  ),
            ),
          ]),
        ),
      ],
    );
  }
}
