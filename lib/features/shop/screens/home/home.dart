import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/all_products/all_products.dart';
import 'package:shopingly/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shopingly/features/shop/screens/home/widgets/home_categories.dart';
import 'package:shopingly/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:shopingly/features/shop/screens/search/search_screen.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: catalog.load,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              PrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// -- Appbar
                    ShopinglyHomeAppBar(),
                    SizedBox(height: ShopinglySizes.spaceBtwSections),

                    /// -- Searchbar
                    ShopinglySearchContainer(
                      text: 'Search in Store',
                      onTap: () => Get.to(() => const SearchScreen()),
                    ),
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
                    Obx(() => ShopinglyPromoSlider(banners: catalog.banners.toList())),
                    Obx(() => SizedBox(height: catalog.banners.isEmpty ? 0 : ShopinglySizes.spaceBtwSections)),

                    ShopinglySectionHeading(title: "Popular Products", onPressed: ()=>Get.to(()=>AllProducts()),),
                    SizedBox(height: ShopinglySizes.spaceBtwItems),

                    /// Popular products
                    ShopinglyCatalogGate(
                      builder: (_) {
                        final popular = catalog.popularProducts();
                        if (popular.isEmpty) {
                          return const ShopinglyEmptyState(
                            title: 'No products yet',
                            subtitle: 'Products will show up here as soon as the store adds them.',
                          );
                        }
                        return ShopinglyGridLayout(
                          itemCount: popular.length,
                          itemBuilder: (_, index) => ShopinglyProductCardVertical(product: popular[index]),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
