import 'package:flutter/material.dart';
import 'package:shopingly/utils/theme/custom_theme/appbar_theme.dart';
import 'package:shopingly/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:shopingly/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:shopingly/utils/theme/custom_theme/chip_theme.dart';
import 'package:shopingly/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:shopingly/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:shopingly/utils/theme/custom_theme/text_field_theme.dart';
import 'package:shopingly/utils/theme/custom_theme/text_theme.dart';

class ShopinglyAppTheme {
  ShopinglyAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.redAccent,
    scaffoldBackgroundColor: Colors.white,
    textTheme: ShopinglyTextTheme.lightTextTheme,
    chipTheme: ShopinglyChipTheme.lightChipTheme,
    appBarTheme: ShopinglyAppBarTheme.lightAppBarTheme,
    checkboxTheme: ShopinglyCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: ShopinglyBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: ShopinglyElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: ShopinglyOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ShopinglyTextFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.redAccent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: ShopinglyTextTheme.darkTextTheme,
    chipTheme: ShopinglyChipTheme.darkChipTheme,
    appBarTheme: ShopinglyAppBarTheme.darkAppBarTheme,
    checkboxTheme: ShopinglyCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: ShopinglyBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: ShopinglyElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: ShopinglyOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ShopinglyTextFieldTheme.darkInputDecorationTheme,
  );
}