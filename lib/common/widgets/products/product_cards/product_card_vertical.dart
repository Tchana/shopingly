import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/styles/shadow.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text.dart';
import 'package:shopingly/features/shop/screens/product_details/product_detail.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyProductCardVertical extends StatelessWidget {
  const ShopinglyProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(()=>ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [ShopinglyShadowStyle.verticalProductShadow],
            borderRadius:
                BorderRadius.circular(ShopinglySizes.productImageRadius),
            color: dark ? ShopinglyColors.darkerGrey : ShopinglyColors.white),
        child: Column(
          children: [
            ShopinglyRoundedContainer(
              height: 180,
              padding: EdgeInsets.all(ShopinglySizes.sm),
              backgroundColor:
                  dark ? ShopinglyColors.dark : ShopinglyColors.light,
              child: Stack(
                children: [
                  ShopinglyRoundedImage(
                      imageUrl: ShopinglyImages.product8, applyImageRadius: true),
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
                      ))
                ],
              ),
            ),

            /// -- Details
            Padding(
              padding: EdgeInsets.only(left: ShopinglySizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShopinglyProductTitleText(
                    title: "Air Jordan Shoes",
                    smallSize: true,
                  ),
                  SizedBox(
                    height: ShopinglySizes.spaceBtwItems / 2,
                  ),
                  ShopinglyBrandTitleText(title: "Nike",),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: ShopinglySizes.sm),
                  child: ShopinglyProductPriceText(price: "35.5", isLarge: true),
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
