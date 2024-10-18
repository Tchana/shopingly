import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyAppBarTheme {
  ShopinglyAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: ShopinglyColors.black, size: 24),
    actionsIconTheme: IconThemeData(color: ShopinglyColors.black, size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: ShopinglyColors.black),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: ShopinglyColors.black, size: 24),
    actionsIconTheme: IconThemeData(color: ShopinglyColors.white, size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: ShopinglyColors.white),
  );
}