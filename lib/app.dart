import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/features/authentication/screens/onboarding/onboarding.dart';
import 'package:shopingly/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ShopinglyAppTheme.lightTheme,
      darkTheme: ShopinglyAppTheme.darkTheme,
      home: OnBoardingScreen(),
    );
  }
}
