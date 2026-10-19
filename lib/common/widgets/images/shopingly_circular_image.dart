import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/images/shopingly_any_image.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyCircularImage extends StatelessWidget {
  const ShopinglyCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = ShopinglySizes.sm,
  });

  final BoxFit? fit;

  /// A bundled `assets/...` path or an `https://` URL.
  final String image;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor ?? (dark ? ShopinglyColors.black : ShopinglyColors.white),
          borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ShopinglyAnyImage(path: image, fit: fit, tint: overlayColor),
      ),
    );
  }
}
