import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyChipTheme {
  ShopinglyChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: ShopinglyColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: ShopinglyColors.black),
    selectedColor: ShopinglyColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: ShopinglyColors.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: ShopinglyColors.grey,
    labelStyle: const TextStyle(color: ShopinglyColors.white),
    selectedColor: ShopinglyColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: ShopinglyColors.white,
  );
}