import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:shopingly/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:shopingly/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/personalization/screens/address/address.dart';
import 'package:shopingly/features/personalization/screens/profile/profile.dart';
import 'package:shopingly/features/shop/screens/cart/cart.dart';
import 'package:shopingly/features/shop/screens/order/order.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
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
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: "My Cart",
                      subTitle: "Add, remove products and move to checkout",
                      onTap:  () => Get.to(() => CartScreen())),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: "My Orders",
                      subTitle: "In progress and completed orders",
                      onTap:  () => Get.to(() => OrderScreen())),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.bank,
                      title: "Bank Account",
                      subTitle: "Withdraw balance to registered bank account",
                      onTap: () {}),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: "My Coupons",
                      subTitle: "List of all the discounted coupons",
                      onTap: () {}),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subTitle: "Set any kind of notification message",
                      onTap: () {}),
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: "Account Privacy",
                      subTitle: "Manage data usage and connected accounts",
                      onTap: () {}),

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
                  ShopinglySettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Load Data",
                      subTitle: "Upload data to your cloud firebase",
                      onTap: () {}),
                  ShopinglySettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subTitle: "Set recommendation based on location",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  ShopinglySettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe Mode",
                    subTitle: "Search results is safe for all ages",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  ShopinglySettingsMenuTile(
                    icon: Iconsax.image,
                    title: "HD image quality",
                    subTitle: "Set image quality to be seen",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// -- logout button
                  SizedBox(
                    height: ShopinglySizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
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
