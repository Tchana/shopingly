import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text_with_verified_icon.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/enums.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyProductMetaData extends StatelessWidget {
  const ShopinglyProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ShopinglyRoundedContainer(
              radius: ShopinglySizes.sm,
              backgroundColor: ShopinglyColors.secondaryColor.withOpacity(0.8),
              padding: EdgeInsets.symmetric(
                  horizontal: ShopinglySizes.sm, vertical: ShopinglySizes.xs),
              child: Text("25%",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: ShopinglyColors.black)),
            ),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            Text('\$250',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            ShopinglyProductPriceText(
              price: '175',
              isLarge: true,
              lineThrough: false,
            ),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 1.5),
        ShopinglyProductTitleText(title: "Green Nike sports shirt"),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ShopinglyProductTitleText(title: "Status"),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            Text(
              "In Stock",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ShopinglyCircularImage(
              image: ShopinglyImages.cosmeticsIcon,
              width: 32,
              height: 32,
              overlayColor: dark ? ShopinglyColors.white : ShopinglyColors.black,
            ),
            ShopinglyBrandTitleTextWithVerifiedIcon(
                title: 'Nike', brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
