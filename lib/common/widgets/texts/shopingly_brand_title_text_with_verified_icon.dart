import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text.dart';
import 'package:shopingly/utils/constants/enums.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglyBrandTitleTextWithVerifiedIcon extends StatelessWidget {
  const ShopinglyBrandTitleTextWithVerifiedIcon(
      {super.key,
      required this.title,
      this.maxLines = 1,
      this.textColor,
      this.iconColor,
      this.textAlign,
      required this.brandTextSize});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ShopinglyBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        SizedBox(
          width: ShopinglySizes.xs,
        ),
        Icon(Iconsax.verify5, color: iconColor, size: ShopinglySizes.iconXs)
      ],
    );
  }
}
