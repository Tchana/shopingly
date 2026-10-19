import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/screens/product_details/product_detail.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// The small "+" button on product cards. Products that need an option picked
/// (colour, size...) open their detail page instead of guessing.
class ShopinglyAddToCartButton extends StatelessWidget {
  const ShopinglyAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final needsChoice = product.attributes.any((a) => a.values.length > 1);
        if (needsChoice) {
          Get.to(() => ProductDetailScreen(product: product));
          return;
        }
        final defaults = {for (final a in product.attributes) if (a.values.isNotEmpty) a.name: a.values.first};
        if (CartController.instance.add(product, attributes: defaults)) {
          ShopinglyLoaders.successSnackBar(title: 'Added to cart', message: product.title);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: product.inStock ? ShopinglyColors.dark : ShopinglyColors.darkGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ShopinglySizes.cardRadiusMd),
            bottomRight: Radius.circular(ShopinglySizes.productImageRadius),
          ),
        ),
        child: SizedBox(
          width: ShopinglySizes.iconLg * 1.2,
          height: ShopinglySizes.iconLg * 1.2,
          child: Center(
            child: Icon(Iconsax.add, color: ShopinglyColors.white),
          ),
        ),
      ),
    );
  }
}
