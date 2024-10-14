import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/constants/text_strings.dart';

class ShopinglyLoginHeader extends StatelessWidget {
  const ShopinglyLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: ShopinglySizes.defaultSpace),
          child: Image(
            height: 100,
            image: AssetImage(dark
                ? ShopinglyImages.lightAppLogo
                : ShopinglyImages.darkAppLogo),
          ),
        ),
        Text(
          ShopinglyTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ShopinglySizes.sm,
        ),
        Text(
          ShopinglyTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
