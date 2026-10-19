import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text_with_verified_icon.dart';
import 'package:shopingly/features/shop/controllers/wishlist_controller.dart';
import 'package:shopingly/features/shop/screens/product_details/product_detail.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyProductCardHorizontal extends StatelessWidget {
  const ShopinglyProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final wishlist = WishlistController.instance;
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
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
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                    ),
                  ),
                  if (product.isOnSale)
                    Positioned(
                      top: 12,
                      child: ShopinglyRoundedContainer(
                        radius: ShopinglySizes.sm,
                        backgroundColor:
                            ShopinglyColors.secondaryColor.withValues(alpha: 0.8),
                        padding: EdgeInsets.symmetric(
                            horizontal: ShopinglySizes.sm,
                            vertical: ShopinglySizes.xs),
                        child: Text("${product.discountPercent}%",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: ShopinglyColors.black)),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Obx(() {
                      final favourite = wishlist.isFavourite(product.id);
                      return ShopinglyCircularIcon(
                        icon: favourite ? Iconsax.heart5 : Iconsax.heart,
                        color: favourite ? Colors.red : null,
                        onPressed: () => wishlist.toggle(product.id),
                      );
                    }),
                  ),
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
                        ShopinglyProductTitleText(title: product.title, smallSize: true),
                        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
                        ShopinglyBrandTitleTextWithVerifiedIcon(title: product.brandName)
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: ShopinglyProductPriceText(
                                price: product.effectivePrice.toStringAsFixed(2))),

                        /// -- Add to Cart
                        ShopinglyAddToCartButton(product: product),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
