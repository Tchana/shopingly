import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/chips/choice_chip.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/product_detail_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyProductAttributes extends StatelessWidget {
  const ShopinglyProductAttributes({super.key, required this.product, required this.controller});

  final ProductModel product;
  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ShopinglyRoundedContainer(
          padding: EdgeInsets.all(ShopinglySizes.md),
          backgroundColor:
              dark ? ShopinglyColors.darkerGrey : ShopinglyColors.grey,
          child: Row(
            children: [
              ShopinglySectionHeading(
                  title: "Details", showActionButton: false),
              SizedBox(width: ShopinglySizes.spaceBtwItems),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ShopinglyProductTitleText(
                        title: 'Price: ',
                        smallSize: true,
                      ),
                      if (product.isOnSale) ...[
                        ShopinglyProductPriceText(
                          price: product.price.toStringAsFixed(2),
                          lineThrough: true,
                        ),
                        SizedBox(width: ShopinglySizes.spaceBtwItems),
                      ],
                      ShopinglyProductPriceText(price: product.effectivePrice.toStringAsFixed(2))
                    ],
                  ),
                  Row(
                    children: [
                      ShopinglyProductTitleText(
                          title: 'Stock: ', smallSize: true),
                      Text(product.inStock ? 'In Stock (${product.stock})' : 'Out of stock',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  if (product.sku.isNotEmpty)
                    Row(
                      children: [
                        ShopinglyProductTitleText(title: 'SKU: ', smallSize: true),
                        Text(product.sku, style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),

        /// -- Attributes (colour, size...) chosen by the store for this product
        for (final attribute in product.attributes)
          if (attribute.values.isNotEmpty) ...[
            SizedBox(height: ShopinglySizes.spaceBtwItems),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShopinglySectionHeading(title: attribute.name, showActionButton: false),
                  SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
                  Obx(
                    () => Wrap(
                      spacing: 8,
                      children: attribute.values
                          .map((value) => ShopinglyChoiceChip(
                                text: value,
                                selected: controller.selectedAttributes[attribute.name] == value,
                                onSelected: (_) => controller.selectAttribute(attribute.name, value),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
      ],
    );
  }
}
