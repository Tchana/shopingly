import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/enums.dart';
import 'package:shopingly/utils/constants/sizes.dart';


class ShopinglyBrandTitleText extends StatelessWidget {
  const ShopinglyBrandTitleText({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small, this.color,
  });

  final String title;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          textAlign: textAlign,
          style: brandTextSize == TextSizes.small ? Theme
              .of(context)
              .textTheme
              .labelMedium!
              .apply(color: color)
          : brandTextSize == TextSizes.medium ? Theme
              .of(context)
              .textTheme
              .bodyLarge!
              .apply(color: color)
          : brandTextSize == TextSizes.large ? Theme
              .of(context)
              .textTheme
              .titleLarge!
              .apply(color: color)
          : Theme
              .of(context)
              .textTheme
              .bodyMedium!
              .apply(color: color),
        ),
        SizedBox(
          width: ShopinglySizes.xs,
        ),
        Icon(Iconsax.verify5,
            color: ShopinglyColors.primaryColor, size: ShopinglySizes.iconXs)
      ],
    );
  }
}
