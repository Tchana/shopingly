import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/features/personalization/controllers/app_settings_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppSettingsController.instance.themeMode.value,
      theme: ShopinglyAppTheme.lightTheme,
      darkTheme: ShopinglyAppTheme.darkTheme,
      // Shown for a moment while AuthenticationRepository decides where to send the user.
      home: const Scaffold(
        backgroundColor: ShopinglyColors.primaryColor,
        body: Center(child: CircularProgressIndicator(color: ShopinglyColors.white)),
      ),
    );
  }
}
