import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/appbar/tabbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/screens/store/widgets/category_tab.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: ShopinglyAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            ShopinglyCartCounterIcon(onPressed: () {}),
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
                  expandedHeight: 440,
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
                        ),
                        SizedBox(
                          height: ShopinglySizes.spaceBtwSections,
                        ),

                        /// -- Feature brands
                        ShopinglySectionHeading(
                          title: "Featured Brands",
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: ShopinglySizes.spaceBtwItems / 2,
                        ),
                        ShopinglyGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              return ShopinglyBrandCard(
                                showBorder: true,
                              );
                            })
                      ],
                    ),
                  ),
                  bottom: ShopinglyTabBar(
                    tabs: [
                      Tab(child: Text("Sports")),
                      Tab(child: Text("Furniture")),
                      Tab(child: Text("Electronics")),
                      Tab(child: Text("Clothes")),
                      Tab(child: Text("Cosmetics")),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: [
                ShopinglyCategoryTab(),
                ShopinglyCategoryTab(),
                ShopinglyCategoryTab(),
                ShopinglyCategoryTab(),
                ShopinglyCategoryTab(),
              ],
            )),
      ),
    );
  }
}
