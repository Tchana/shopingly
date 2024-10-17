import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    TextButton(
                        onPressed: () {},
                        child: Text("Change profile picture")),
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

              ShopinglyProfileMenu(
                onPressed: () {},
                title: "Name",
                value: "Tchana Valdo",
              ),
              ShopinglyProfileMenu(
                onPressed: () {},
                title: "Username",
                value: "Tchana Valdo",
              ),

              SizedBox(height: ShopinglySizes.spaceBtwItems),
              Divider(),
              SizedBox(height: ShopinglySizes.spaceBtwItems),

              ShopinglySectionHeading(
                  title: "Personal Information", showActionButton: false),
              SizedBox(height: ShopinglySizes.spaceBtwItems),

              ShopinglyProfileMenu(
                  onPressed: () {},
                  title: "User ID",
                  value: "19954",
                  icon: Iconsax.copy),
              ShopinglyProfileMenu(
                onPressed: () {},
                title: "E-mail",
                value: "valdotnv@gmail.com",
              ),
              ShopinglyProfileMenu(
                onPressed: () {},
                title: "Phone Number",
                value: "+237-656-388-275",
              ),
              ShopinglyProfileMenu(
                onPressed: () {},
                title: "Gender",
                value: "Male",
              ),
              ShopinglyProfileMenu(
                onPressed: () {},
                title: "Date of birth",
                value: "23 Sept 1997",
              ),
              Divider(),
              SizedBox(height: ShopinglySizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text('Close Account', style: TextStyle(color: Colors.red),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
