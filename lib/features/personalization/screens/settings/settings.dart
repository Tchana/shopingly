import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:shopingly/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:shopingly/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/data/repositories/authentication/authentication_repository.dart';
import 'package:shopingly/features/personalization/controllers/app_settings_controller.dart';
import 'package:shopingly/features/personalization/screens/address/address.dart';
import 'package:shopingly/features/personalization/screens/coupons/my_coupons.dart';
import 'package:shopingly/features/personalization/screens/profile/profile.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/cart/cart.dart';
import 'package:shopingly/features/shop/screens/order/order.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _contactSupport() async {
    final email = CatalogController.instance.settings.value.supportEmail;
    final uri = Uri(scheme: 'mailto', path: email, queryParameters: {'subject': 'Support request'});
    if (!await launchUrl(uri)) {
      ShopinglyLoaders.warningSnackBar(title: 'No e-mail app found', message: 'Write to us at $email');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final settings = AppSettingsController.instance;
    final cart = CartController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- Header
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  ShopinglyAppBar(
                    title: Text(
                      "Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: ShopinglyColors.white),
                    ),
                  ),
                  ShopinglyUserProfileTile(onPressed: () => Get.to(()=> ProfileScreen()),),
                  SizedBox(height: ShopinglySizes.spaceBtwSections),
                ],
              ),
            ),

            /// -- Body
            Padding(
              padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
              child: Column(
                children: [
                  ShopinglySectionHeading(
                    title: "Account Settings",
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: ShopinglySizes.spaceBtwItems,
                  ),

                  ShopinglySettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: "My Addresses",
                      subTitle: "Set shopping delivery address",
                      onTap: () => Get.to(() => UserAddressScreen())),
                  Obx(
                    () => ShopinglySettingsMenuTile(
                        icon: Iconsax.shopping_cart,
                        title: "My Cart",
                        subTitle: cart.count == 0
                            ? "Add, remove products and move to checkout"
                            : "${cart.count} ${cart.count == 1 ? 'item' : 'items'} waiting for checkout",
                        onTap: () => Get.to(() => CartScreen())),
                  ),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: "My Orders",
                      subTitle: "In progress and completed orders",
                      onTap: () => Get.to(() => OrderScreen())),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: "My Coupons",
                      subTitle: "List of all the discounted coupons",
                      onTap: () => Get.to(() => const MyCouponsScreen())),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.message_question,
                      title: "Help & Support",
                      subTitle: "Get in touch with the store",
                      onTap: _contactSupport),

                  /// -- App settings
                  SizedBox(
                    height: ShopinglySizes.spaceBtwSections,
                  ),
                  ShopinglySectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: ShopinglySizes.spaceBtwItems,
                  ),
                  Obx(
                    () => ShopinglySettingsMenuTile(
                      icon: Iconsax.moon,
                      title: "Dark Mode",
                      subTitle: "Switch between the light and dark theme",
                      trailing: Switch(
                        value: settings.themeMode.value == ThemeMode.dark ||
                            (settings.themeMode.value == ThemeMode.system && dark),
                        onChanged: settings.setDark,
                      ),
                    ),
                  ),

                  /// -- logout button
                  SizedBox(
                    height: ShopinglySizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => AuthenticationRepository.instance.logout(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: dark ? ShopinglyColors.white : ShopinglyColors.primaryColor),
                      ),
                      child: Text("Logout"),
                    ),
                  ),
                  SizedBox(
                    height: ShopinglySizes.spaceBtwSections * 2.5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
