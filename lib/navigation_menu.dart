import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/personalization/screens/settings/settings.dart';
import 'package:shopingly/features/shop/screens/home/home.dart';
import 'package:shopingly/features/shop/screens/store/store.dart';
import 'package:shopingly/features/shop/screens/wishlist/wishlist.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = ShopinglyHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () =>  NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? ShopinglyColors.black : ShopinglyColors.white,
          indicatorColor: darkMode ? ShopinglyColors.white.withOpacity(0.1) : ShopinglyColors.black.withOpacity(0.1),

          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(()=>controller.screens[controller.selectedIndex.value],),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [HomeScreen(), StoreScreen(), FavouriteScreen(), SettingsScreen(),];
}
