import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/features/personalization/screens/profile/edit_profile.dart';
import 'package:shopingly/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/popups/loaders.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserController.instance.user;
    void edit() => Get.to(() => const EditProfileScreen());
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              /// Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    ShopinglyCircularImage(
                        image: ShopinglyImages.user, width: 80, height: 80),
                  ],
                ),
              ),

              /// -- Details
              SizedBox(
                height: ShopinglySizes.spaceBtwItems / 2,
              ),
              Divider(),
              SizedBox(
                height: ShopinglySizes.spaceBtwItems,
              ),
              ShopinglySectionHeading(
                title: "Profile information",
                showActionButton: false,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwItems,
              ),

              Obx(() => ShopinglyProfileMenu(
                    onPressed: edit,
                    title: "Name",
                    value: user.value.fullName,
                  )),
              Obx(() => ShopinglyProfileMenu(
                    onPressed: edit,
                    title: "Username",
                    value: user.value.username,
                  )),

              SizedBox(height: ShopinglySizes.spaceBtwItems),
              Divider(),
              SizedBox(height: ShopinglySizes.spaceBtwItems),

              ShopinglySectionHeading(
                  title: "Personal Information", showActionButton: false),
              SizedBox(height: ShopinglySizes.spaceBtwItems),

              Obx(() => ShopinglyProfileMenu(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: user.value.id));
                    ShopinglyLoaders.successSnackBar(title: 'Copied', message: 'User ID copied to clipboard.');
                  },
                  title: "User ID",
                  value: user.value.id,
                  icon: Iconsax.copy)),
              Obx(() => ShopinglyProfileMenu(
                    onPressed: () => ShopinglyLoaders.warningSnackBar(
                        title: 'E-mail', message: 'Your e-mail is your sign-in and cannot be changed here.'),
                    title: "E-mail",
                    value: user.value.email,
                    icon: Iconsax.lock,
                  )),
              Obx(() => ShopinglyProfileMenu(
                    onPressed: edit,
                    title: "Phone Number",
                    value: user.value.phoneNumber,
                  )),
              Divider(),
              SizedBox(height: ShopinglySizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => _confirmClose(context),
                  child: Text('Close Account', style: TextStyle(color: Colors.red),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmClose(BuildContext context) async {
    final password = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Close your account?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This permanently deletes your profile and saved addresses. Enter your password to confirm.'),
            const SizedBox(height: ShopinglySizes.spaceBtwItems),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Iconsax.password_check)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete account', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    final typed = password.text;
    password.dispose();
    if (confirmed != true || typed.isEmpty) return;
    await UserController.instance.deleteAccount(typed);
  }
}
