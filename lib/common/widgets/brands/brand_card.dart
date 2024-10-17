import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/enums.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';



class ShopinglyBrandCard extends StatelessWidget {
  const ShopinglyBrandCard({
    super.key, required this.showBorder, this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: ShopinglyRoundedContainer(
        padding: EdgeInsets.all(ShopinglySizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: ShopinglyCircularImage(
                image: ShopinglyImages.clothIcon,
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
                overlayColor: dark
                    ? ShopinglyColors.white
                    : ShopinglyColors.black,
              ),
            ),
            SizedBox(
              width: ShopinglySizes.spaceBtwItems / 2,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  ShopinglyBrandTitleText(
                      title: "Nike",
                      brandTextSize: TextSizes.large),
                  Text(
                    "256 Products",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}