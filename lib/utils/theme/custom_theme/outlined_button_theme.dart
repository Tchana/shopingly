import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyOutlinedButtonTheme {
  ShopinglyOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ShopinglyColors.black,
      side: const BorderSide(color: ShopinglyColors.primaryColor),
      textStyle: const TextStyle(fontSize: 16, color: ShopinglyColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ShopinglyColors.white,
      side: const BorderSide(color: ShopinglyColors.primaryColor),
      textStyle: const TextStyle(fontSize: 16, color: ShopinglyColors.white, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}