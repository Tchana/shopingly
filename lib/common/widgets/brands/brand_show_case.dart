import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyBrandShowCase extends StatelessWidget {
  const ShopinglyBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

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
          ShopinglyBrandCard(showBorder: false),
          SizedBox(height: ShopinglySizes.spaceBtwItems,),
          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Expanded(
      child: ShopinglyRoundedContainer(
        height: 100,
        backgroundColor:
        dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
        margin: EdgeInsets.only(right: ShopinglySizes.sm),
        padding: EdgeInsets.all(
          ShopinglySizes.md,
        ),
        child: Image(
            fit: BoxFit.contain, image: AssetImage(image)),
      ),
    );
  }
}