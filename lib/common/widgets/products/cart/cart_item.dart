import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/common/widgets/texts/product_title_text.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text_with_verified_icon.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyCartItem extends StatelessWidget {
  const ShopinglyCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        ShopinglyRoundedImage(
          imageUrl: ShopinglyImages.product1,
          width: 60,
          height: 60,
          padding: EdgeInsets.all(ShopinglySizes.sm),
          backgroundColor:
          dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
        ),
        SizedBox(width: ShopinglySizes.spaceBtwItems),
        /// -- Title, Price and size
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShopinglyBrandTitleTextWithVerifiedIcon(title: "Nike",),
            Flexible(child: ShopinglyProductTitleText(title: "Nike Sport shoes", maxLines: 1)),
            /// -- Attributes
            Text.rich(TextSpan(
                children: [
                  TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: 'Green ', style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: 'UK 08 ', style: Theme.of(context).textTheme.bodyLarge),
                ]
            ))
          ],
        ),
      ],
    );
  }
}