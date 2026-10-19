import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text_with_verified_icon.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/enums.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyProductMetaData extends StatelessWidget {
  const ShopinglyProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (product.isOnSale) ...[
              ShopinglyRoundedContainer(
                radius: ShopinglySizes.sm,
                backgroundColor: ShopinglyColors.secondaryColor.withValues(alpha: 0.8),
                padding: EdgeInsets.symmetric(
                    horizontal: ShopinglySizes.sm, vertical: ShopinglySizes.xs),
                child: Text("${product.discountPercent}%",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: ShopinglyColors.black)),
              ),
              SizedBox(width: ShopinglySizes.spaceBtwItems),
              ShopinglyProductPriceText(
                price: product.price.toStringAsFixed(2),
                lineThrough: true,
              ),
              SizedBox(width: ShopinglySizes.spaceBtwItems),
            ],
            ShopinglyProductPriceText(
              price: product.effectivePrice.toStringAsFixed(2),
              isLarge: true,
              lineThrough: false,
            ),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 1.5),
        ShopinglyProductTitleText(title: product.title),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ShopinglyProductTitleText(title: "Status"),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            Text(
              product.inStock ? "In Stock" : "Out of stock",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        if (product.brandName.isNotEmpty) ...[
          SizedBox(height: ShopinglySizes.spaceBtwItems / 1.5),
          Row(
            children: [
              if (product.brandImage.isNotEmpty)
                ShopinglyCircularImage(
                  image: product.brandImage,
                  width: 32,
                  height: 32,
                  overlayColor: dark ? ShopinglyColors.white : ShopinglyColors.black,
                ),
              ShopinglyBrandTitleTextWithVerifiedIcon(
                  title: product.brandName, brandTextSize: TextSizes.medium),
            ],
          ),
        ],
      ],
    );
  }
}
