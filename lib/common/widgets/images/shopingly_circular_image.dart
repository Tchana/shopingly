import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyCircularImage extends StatelessWidget {
  const ShopinglyCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = ShopinglySizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
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
        child: Image(
          fit: fit,
            image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
            color: overlayColor,),
      ),
    );

  }
}
