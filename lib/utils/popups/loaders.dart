import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyLoaders {
  static void successSnackBar({required String title, String message = ''}) {
    _show(title, message, ShopinglyColors.primaryColor, Iconsax.check);
  }

  static void warningSnackBar({required String title, String message = ''}) {
    _show(title, message, Colors.orange, Iconsax.warning_2);
  }

  static void errorSnackBar({required String title, String message = ''}) {
    _show(title, message, Colors.red.shade600, Iconsax.warning_2);
  }

  static void _show(String title, String message, Color color, IconData icon) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: Icon(icon, color: Colors.white),
    );
  }
}
