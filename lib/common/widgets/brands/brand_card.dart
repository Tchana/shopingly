import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/common/widgets/texts/shopingly_brand_title_text.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/enums.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyBrandCard extends StatelessWidget {
  const ShopinglyBrandCard({
    super.key, required this.brand, required this.showBorder, this.onTap,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final count = CatalogController.instance.productCountForBrand(brand.id);
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
                image: brand.image,
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
                      title: brand.name,
                      brandTextSize: TextSizes.large),
                  Text(
                    "$count ${count == 1 ? 'Product' : 'Products'}",
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
