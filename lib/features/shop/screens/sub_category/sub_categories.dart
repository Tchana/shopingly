import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Sports"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              /// -- Banner
              ShopinglyRoundedImage(
                  imageUrl: ShopinglyImages.promoBanner3,
                  width: double.infinity,
                  applyImageRadius: true),
              SizedBox(height: ShopinglySizes.spaceBtwSections),

              /// -- Sub-Categories
              Column(
                children: [
                  ShopinglySectionHeading(
                      title: "Sports Shirts", onPressed: () {}),
                  SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      separatorBuilder: (_, __) => SizedBox(
                        width: ShopinglySizes.spaceBtwItems,
                      ),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => ShopinglyProductCardHorizontal()
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
