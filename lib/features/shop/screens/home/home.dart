import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shopingly/features/shop/screens/home/widgets/home_categories.dart';
import 'package:shopingly/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  /// -- Appbar
                  ShopinglyHomeAppBar(),
                  SizedBox(height: ShopinglySizes.spaceBtwSections),

                  /// -- Searchbar
                  ShopinglySearchContainer(text: 'Search in Store'),
                  SizedBox(height: ShopinglySizes.spaceBtwSections),

                  /// -- Categories
                  Padding(
                    padding: EdgeInsets.only(left: ShopinglySizes.defaultSpace),
                    child: Column(
                      children: [
                        /// -- Heading
                        ShopinglySectionHeading(
                            title: 'Popular Categories',
                            showActionButton: false,
                            textColor: ShopinglyColors.white),
                        SizedBox(height: ShopinglySizes.spaceBtwItems),

                        /// -- Categories
                        ShopinglyHomeCategories(),
                        SizedBox(height: ShopinglySizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(ShopinglySizes.defaultSpace,),
              child: Column(
                children: [
                  ShopinglyPromoSlider(
                    banners: [
                      ShopinglyImages.promoBanner1,
                      ShopinglyImages.promoBanner2,
                      ShopinglyImages.promoBanner3
                    ],
                  ),
                  SizedBox(height: ShopinglySizes.spaceBtwSections),

                  ShopinglySectionHeading(title: "Popular Products", onPressed: (){},),
                  SizedBox(height: ShopinglySizes.spaceBtwItems),

                  /// Popular products
                  ShopinglyGridLayout(itemCount: 4, itemBuilder: (_, index) => ShopinglyProductCardVertical())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
