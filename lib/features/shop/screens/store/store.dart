import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/appbar/tabbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/brand/all_brands.dart';
import 'package:shopingly/features/shop/screens/brand/brand_products.dart';
import 'package:shopingly/features/shop/screens/search/search_screen.dart';
import 'package:shopingly/features/shop/screens/store/widgets/category_tab.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final catalog = CatalogController.instance;
    return Obx(() {
      final categories = catalog.topCategories;
      final brands = catalog.featuredBrands.take(4).toList();
      return DefaultTabController(
        // A new key makes the controller adopt the tab count once categories finish loading.
        key: ValueKey(categories.length),
        length: categories.length,
        child: Scaffold(
          appBar: ShopinglyAppBar(
            title:
                Text('Store', style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              ShopinglyCartCounterIcon(),
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrollable) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor:
                        dark ? ShopinglyColors.black : ShopinglyColors.white,
                    expandedHeight: brands.isEmpty ? 150 : 150 + (brands.length > 2 ? 2 : 1) * 92 + 60,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: ShopinglySizes.spaceBtwItems,
                          ),
                          ShopinglySearchContainer(
                            text: "Search in store",
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                            onTap: () => Get.to(() => const SearchScreen()),
                          ),
                          if (brands.isNotEmpty) ...[
                            SizedBox(
                              height: ShopinglySizes.spaceBtwSections,
                            ),

                            /// -- Feature brands
                            ShopinglySectionHeading(
                              title: "Featured Brands",
                              onPressed: () => Get.to(() => AllBrandsScreen()),
                            ),
                            SizedBox(
                              height: ShopinglySizes.spaceBtwItems / 2,
                            ),
                            ShopinglyGridLayout(
                                itemCount: brands.length,
                                mainAxisExtent: 80,
                                itemBuilder: (_, index) {
                                  return ShopinglyBrandCard(
                                    brand: brands[index],
                                    showBorder: true,
                                    onTap: () => Get.to(() => BrandProducts(brand: brands[index])),
                                  );
                                })
                          ],
                        ],
                      ),
                    ),
                    bottom: categories.isEmpty
                        ? null
                        : ShopinglyTabBar(
                            tabs: categories.map((c) => Tab(child: Text(c.name))).toList(),
                          ),
                  )
                ];
              },
              body: categories.isEmpty
                  ? ShopinglyEmptyState(
                      title: catalog.isLoading.value ? 'Loading the store...' : 'No categories yet',
                      subtitle: catalog.isLoading.value ? '' : 'Categories will appear here once the store adds them.',
                    )
                  : TabBarView(
                      children: categories.map((c) => ShopinglyCategoryTab(category: c)).toList(),
                    )),
        ),
      );
    });
  }
}
