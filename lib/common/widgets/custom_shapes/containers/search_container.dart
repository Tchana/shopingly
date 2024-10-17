import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/device/device_utility.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglySearchContainer extends StatelessWidget {
  const ShopinglySearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding =
        const EdgeInsets.symmetric(horizontal: ShopinglySizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: ShopinglyDeviceUtils.getScreenWidth(),
          padding: EdgeInsets.all(ShopinglySizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? ShopinglyColors.dark
                    : ShopinglyColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(ShopinglySizes.cardRadiusLg),
            border: showBorder ? Border.all(color: ShopinglyColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: ShopinglyColors.darkerGrey,
              ),
              SizedBox(
                width: ShopinglySizes.spaceBtwItems,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: ShopinglyColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
