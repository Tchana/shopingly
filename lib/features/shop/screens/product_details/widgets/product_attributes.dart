import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/chips/choice_chip.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyProductAttributes extends StatelessWidget {
  const ShopinglyProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ShopinglyRoundedContainer(
          padding: EdgeInsets.all(ShopinglySizes.md),
          backgroundColor:
              dark ? ShopinglyColors.darkerGrey : ShopinglyColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  ShopinglySectionHeading(
                      title: "Variation", showActionButton: false),
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
                          Text(
                            "\$25",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: ShopinglySizes.spaceBtwItems),
                          ShopinglyProductPriceText(price: '20')
                        ],
                      ),
                      Row(
                        children: [
                          ShopinglyProductTitleText(
                              title: 'Stock: ', smallSize: true),
                          Text('In Stock',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              ShopinglyProductTitleText(
                title:
                    'This is the description of the product and it can go to up to 4 lines.',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems),

        /// -- Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShopinglySectionHeading(title: 'Colors', showActionButton: false),
            SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                ShopinglyChoiceChip(
                  text: 'Green',
                  selected: true,
                  onSelected: (value) {},
                ),
                ShopinglyChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                ShopinglyChoiceChip(
                  text: 'Yellow',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShopinglySectionHeading(title: 'Size', showActionButton: false),
            SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                ShopinglyChoiceChip(
                  text: 'EU 34',
                  selected: true,
                  onSelected: (value) {},
                ),
                ShopinglyChoiceChip(
                  text: 'EU 36',
                  selected: false,
                  onSelected: (value) {},
                ),
                ShopinglyChoiceChip(
                  text: 'EU 38',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
