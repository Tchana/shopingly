import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglySocialButtons extends StatelessWidget {
  const ShopinglySocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ShopinglyColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: ShopinglySizes.iconMd,
              height: ShopinglySizes.iconMd,
              image: AssetImage(ShopinglyImages.google),
            ),
          ),
        ),
        const SizedBox(
          width: ShopinglySizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ShopinglyColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: ShopinglySizes.iconMd,
              height: ShopinglySizes.iconMd,
              image: AssetImage(ShopinglyImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}