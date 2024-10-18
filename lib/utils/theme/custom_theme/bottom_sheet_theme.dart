import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyBottomSheetTheme {
  ShopinglyBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: ShopinglyColors.white,
    modalBackgroundColor: ShopinglyColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: ShopinglyColors.black,
    modalBackgroundColor: ShopinglyColors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}