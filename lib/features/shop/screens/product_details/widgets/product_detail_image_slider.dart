import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyProductImageSlider extends StatelessWidget {
  const ShopinglyProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return ShopinglyCurvedEdgesWidget(
      child: Container(
        color:
        dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
        child: Stack(
          children: [
            /// --Main Large image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(
                    ShopinglySizes.productImageRadius * 2),
                child: Center(
                  child: Image(
                    image: AssetImage(ShopinglyImages.product1),
                  ),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: ShopinglySizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(
                    width: ShopinglySizes.spaceBtwItems,
                  ),
                  itemCount: 4,
                  itemBuilder: (_, index) => ShopinglyRoundedImage(
                    imageUrl: ShopinglyImages.product6,
                    width: 80,
                    backgroundColor:
                    dark ? ShopinglyColors.dark : ShopinglyColors.light,
                    border: Border.all(color: ShopinglyColors.primaryColor),
                    padding: EdgeInsets.all(ShopinglySizes.sm),
                  ),
                ),
              ),
            ),

            /// -- App bar icons
            ShopinglyAppBar(
              showBackArrow: true,
              actions: [
                ShopinglyCircularIcon(icon: Iconsax.heart5, color: Colors.red,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
