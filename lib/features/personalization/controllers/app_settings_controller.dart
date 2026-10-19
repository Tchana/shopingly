import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// App preferences that survive restarts. Currently the light/dark theme.
class AppSettingsController extends GetxController {
  static AppSettingsController get instance => Get.find();

  static const _themeKey = 'themeMode';

  final _storage = GetStorage();

  final themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value = switch (_storage.read<String>(_themeKey)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  bool isDark(BuildContext context) => themeMode.value == ThemeMode.dark ||
      (themeMode.value == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark);

  void setDark(bool dark) {
    themeMode.value = dark ? ThemeMode.dark : ThemeMode.light;
    _storage.write(_themeKey, dark ? 'dark' : 'light');
    Get.changeThemeMode(themeMode.value);
  }
}
