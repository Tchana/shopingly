import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ProductQuantityWithAddRemoveButtonVertical extends StatelessWidget {
  const ProductQuantityWithAddRemoveButtonVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ShopinglyCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ShopinglySizes.md,
          color: dark ? ShopinglyColors.white : ShopinglyColors.darkerGrey,
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 5),
        ShopinglyRoundedContainer(
          radius: ShopinglySizes.sm,
          backgroundColor: ShopinglyColors.primaryColor.withOpacity(0.8),
          padding: EdgeInsets.symmetric(
              horizontal: ShopinglySizes.md, vertical: ShopinglySizes.xs),
          child: Row(
            children: [
              Text("(2) ",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: ShopinglyColors.white)),
              ShopinglyProductPriceText(price: "300"),
            ],
          ),
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 5),
        ShopinglyCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ShopinglySizes.md,
          color: dark ? ShopinglyColors.white : ShopinglyColors.darkerGrey,
        ),
      ],
    );
  }
}