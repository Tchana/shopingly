import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyCheckboxTheme {
  ShopinglyCheckboxTheme._();

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if( states.contains(WidgetState.selected)) {
        return ShopinglyColors.white;
      } else {
        return ShopinglyColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states){
      if( states.contains(WidgetState.selected)) {
        return ShopinglyColors.primaryColor;
      } else {
        return Colors.transparent;
      }
    }),
  );

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if( states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states){
      if( states.contains(WidgetState.selected)) {
        return Colors.redAccent;
      } else {
        return Colors.transparent;
      }
    }),
  );
}