import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyBottomAddToCart extends StatelessWidget {
  const ShopinglyBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ShopinglySizes.defaultSpace,
          vertical: ShopinglySizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ShopinglySizes.cardRadiusLg),
            topRight: Radius.circular(ShopinglySizes.cardRadiusLg),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ShopinglyCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: ShopinglyColors.darkGrey,
                width: 40,
                height: 40,
                color: ShopinglyColors.white,
              ),
              SizedBox(width: ShopinglySizes.spaceBtwItems),
              Text("2", style: Theme.of(context).textTheme.titleSmall),
              SizedBox(width: ShopinglySizes.spaceBtwItems),
              ShopinglyCircularIcon(
                icon: Iconsax.add,
                backgroundColor: ShopinglyColors.black,
                width: 40,
                height: 40,
                color: ShopinglyColors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(ShopinglySizes.md),
              backgroundColor: ShopinglyColors.black,
              side: BorderSide(color: ShopinglyColors.black),
            ),
            child: Text("Add to Cart"),
          )
        ],
      ),
    );
  }
}
