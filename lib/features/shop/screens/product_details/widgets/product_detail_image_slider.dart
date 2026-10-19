import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/images/shopingly_any_image.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/features/shop/controllers/product_detail_controller.dart';
import 'package:shopingly/features/shop/controllers/wishlist_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyProductImageSlider extends StatelessWidget {
  const ShopinglyProductImageSlider({
    super.key,
    required this.product,
    required this.controller,
  });

  final ProductModel product;
  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final gallery = product.gallery;
    final wishlist = WishlistController.instance;
    return ShopinglyCurvedEdgesWidget(
      child: Container(
        color:
        dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
        child: Stack(
          children: [
            /// --Main Large image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(
                    ShopinglySizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() => ShopinglyAnyImage(path: controller.selectedImage.value)),
                ),
              ),
            ),

            /// Image Slider
            if (gallery.length > 1)
              Positioned(
                right: 0,
                bottom: 30,
                left: ShopinglySizes.defaultSpace,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => SizedBox(
                      width: ShopinglySizes.spaceBtwItems,
                    ),
                    itemCount: gallery.length,
                    itemBuilder: (_, index) => Obx(
                      () => ShopinglyRoundedImage(
                        imageUrl: gallery[index],
                        width: 80,
                        onPressed: () => controller.selectedImage.value = gallery[index],
                        backgroundColor:
                        dark ? ShopinglyColors.dark : ShopinglyColors.light,
                        border: Border.all(
                          color: controller.selectedImage.value == gallery[index]
                              ? ShopinglyColors.primaryColor
                              : Colors.transparent,
                        ),
                        padding: EdgeInsets.all(ShopinglySizes.sm),
                      ),
                    ),
                  ),
                ),
              ),

            /// -- App bar icons
            ShopinglyAppBar(
              showBackArrow: true,
              actions: [
                Obx(() {
                  final favourite = wishlist.isFavourite(product.id);
                  return ShopinglyCircularIcon(
                    icon: favourite ? Iconsax.heart5 : Iconsax.heart,
                    color: favourite ? Colors.red : null,
                    onPressed: () => wishlist.toggle(product.id),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
