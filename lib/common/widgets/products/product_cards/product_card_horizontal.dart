import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text_with_verified_icon.dart';

import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyProductCardHorizontal extends StatelessWidget {
  const ShopinglyProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(ShopinglySizes.productImageRadius),
          color: dark ? ShopinglyColors.darkerGrey : ShopinglyColors.softGrey),
      child: Row(
        children: [
          /// -- Thumbnail
          ShopinglyRoundedContainer(
            height: 120,
            padding: EdgeInsets.all(ShopinglySizes.sm),
            backgroundColor:
                dark ? ShopinglyColors.dark : ShopinglyColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ShopinglyRoundedImage(
                    imageUrl: ShopinglyImages.product1,
                    applyImageRadius: true,
                  ),
                ),
                Positioned(
                  top: 12,
                  child: ShopinglyRoundedContainer(
                    radius: ShopinglySizes.sm,
                    backgroundColor:
                        ShopinglyColors.secondaryColor.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(
                        horizontal: ShopinglySizes.sm,
                        vertical: ShopinglySizes.xs),
                    child: Text("25%",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: ShopinglyColors.black)),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: ShopinglyCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    )),
              ],
            ),
          ),

          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: ShopinglySizes.sm, left: ShopinglySizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShopinglyProductTitleText(title: 'Green Nike half Sleeves shirt', smallSize: true),
                      SizedBox(height: ShopinglySizes.spaceBtwItems /2),

                      ShopinglyBrandTitleTextWithVerifiedIcon(title: "Nike")
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: ShopinglyProductPriceText(price: "300.0")),


                      /// -- Add to Cart
                      Container(
                        decoration: BoxDecoration(
                          color: ShopinglyColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ShopinglySizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                                ShopinglySizes.productImageRadius),
                          ),
                        ),
                        child: SizedBox(
                          width: ShopinglySizes.iconLg * 1.2,
                          height: ShopinglySizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: ShopinglyColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
