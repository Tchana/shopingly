import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text_with_verified_icon.dart';
import 'package:shopingly/features/shop/models/cart_item_model.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyCartItem extends StatelessWidget {
  const ShopinglyCartItem({
    super.key,
    required this.item,
  });

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Expanded(
      child: Row(
        children: [
          ShopinglyRoundedImage(
            imageUrl: item.image,
            width: 60,
            height: 60,
            padding: EdgeInsets.all(ShopinglySizes.sm),
            backgroundColor:
            dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
          ),
          SizedBox(width: ShopinglySizes.spaceBtwItems),
          /// -- Title, Price and size
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.brandName.isNotEmpty) ShopinglyBrandTitleTextWithVerifiedIcon(title: item.brandName),
                ShopinglyProductTitleText(title: item.title, maxLines: 1),
                /// -- Attributes
                if (item.attributes.isNotEmpty)
                  Text.rich(TextSpan(
                      children: [
                        for (final entry in item.attributes.entries) ...[
                          TextSpan(text: '${entry.key} ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: '${entry.value}  ', style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ]
                  ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
