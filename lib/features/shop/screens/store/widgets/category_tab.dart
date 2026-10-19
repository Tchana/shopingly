import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/brands/brand_show_case.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/all_products/all_products.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyCategoryTab extends StatelessWidget {
  const ShopinglyCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Obx(() {
      final products = catalog.productsFor(categoryId: category.id);
      final brands = catalog.brandsInCategory(category.id).take(2).toList();
      if (products.isEmpty) {
        return ShopinglyEmptyState(
          title: 'Nothing in ${category.name} yet',
          subtitle: 'Check back soon.',
        );
      }
      final shown = ProductSort.newest.apply(products).take(4).toList();
      return ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
            child: Column(
              children: [
                /// -- Brands
                for (final brand in brands)
                  ShopinglyBrandShowCase(
                    brand: brand,
                    products: products.where((p) => p.brandId == brand.id).toList(),
                  ),
                SizedBox(height: ShopinglySizes.spaceBtwItems,),

                /// -- Products
                ShopinglySectionHeading(
                  title: "You might like",
                  onPressed: () => Get.to(() => AllProducts(title: category.name, categoryId: category.id)),
                ),
                SizedBox(height: ShopinglySizes.spaceBtwItems,),

                ShopinglyGridLayout(
                  itemCount: shown.length,
                  itemBuilder: (_, index) => ShopinglyProductCardVertical(product: shown[index]),
                ),
                SizedBox(height: ShopinglySizes.spaceBtwItems,),
              ],
            ),
          ),
        ],
      );
    });
  }
}
