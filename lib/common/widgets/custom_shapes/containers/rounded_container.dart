import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglyRoundedContainer extends StatelessWidget {
  const ShopinglyRoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = ShopinglySizes.cardRadiusLg,
      this.child,
      this.showBorder = false,
      this.borderColor = ShopinglyColors.borderPrimary,
      this.backgroundColor = ShopinglyColors.white,
      this.padding,
      this.margin});

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
