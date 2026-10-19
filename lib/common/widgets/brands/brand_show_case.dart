import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_any_image.dart';
import 'package:shopingly/features/shop/screens/product_details/product_detail.dart';
import 'package:shopingly/features/shop/screens/brand/brand_products.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// A brand with up to three of its products, shown in the store's category tabs.
class ShopinglyBrandShowCase extends StatelessWidget {
  const ShopinglyBrandShowCase({
    super.key,
    required this.brand,
    required this.products,
  });

  final BrandModel brand;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ShopinglyRoundedContainer(
      showBorder: true,
      borderColor: ShopinglyColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.all(ShopinglySizes.md),
      margin: EdgeInsets.only(bottom: ShopinglySizes.spaceBtwItems),
      child: Column(
        children: [
          ShopinglyBrandCard(
            brand: brand,
            showBorder: false,
            onTap: () => Get.to(() => BrandProducts(brand: brand)),
          ),
          SizedBox(height: ShopinglySizes.spaceBtwItems,),
          Row(
            children: products
                .take(3)
                .map((p) => brandTopProductImageWidget(p, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(ProductModel product, BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => Get.to(() => ProductDetailScreen(product: product)),
        child: ShopinglyRoundedContainer(
          height: 100,
          backgroundColor:
          dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
          margin: EdgeInsets.only(right: ShopinglySizes.sm),
          padding: EdgeInsets.all(
            ShopinglySizes.md,
          ),
          child: ShopinglyAnyImage(path: product.thumbnail),
        ),
      ),
    );
  }
}
