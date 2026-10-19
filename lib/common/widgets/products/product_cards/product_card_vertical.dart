import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/styles/shadow.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text.dart';
import 'package:shopingly/features/shop/controllers/wishlist_controller.dart';
import 'package:shopingly/features/shop/screens/product_details/product_detail.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyProductCardVertical extends StatelessWidget {
  const ShopinglyProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final wishlist = WishlistController.instance;
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
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
                  Positioned.fill(
                    child: Opacity(
                      opacity: product.inStock ? 1 : 0.4,
                      child: ShopinglyRoundedImage(
                          imageUrl: product.thumbnail, applyImageRadius: true),
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
                  if (!product.inStock)
                    Center(
                      child: Text('Sold out', style: Theme.of(context).textTheme.titleMedium),
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
                  )
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
                    title: product.title,
                    smallSize: true,
                  ),
                  SizedBox(
                    height: ShopinglySizes.spaceBtwItems / 2,
                  ),
                  ShopinglyBrandTitleText(title: product.brandName),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: ShopinglySizes.sm),
                    child: ShopinglyProductPriceText(
                        price: product.effectivePrice.toStringAsFixed(2), isLarge: true),
                  ),
                ),
                ShopinglyAddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
