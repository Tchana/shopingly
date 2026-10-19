import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:shopingly/common/widgets/products/sortable/sortable_products.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/all_products/all_products.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// A category page: one horizontal row of products per sub-category, or a plain
/// product grid when the category has no sub-categories.
class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Obx(() {
            final children = catalog.childrenOf(category.id)
                .where((c) => catalog.productsFor(categoryId: c.id).isNotEmpty)
                .toList();
            if (children.isEmpty) {
              return ShopinglySortableProducts(
                products: catalog.productsFor(categoryId: category.id),
                emptyTitle: 'Nothing in ${category.name} yet',
              );
            }
            return Column(
              children: [
                for (final child in children) ...[
                  ShopinglySectionHeading(
                    title: child.name,
                    onPressed: () => Get.to(() => AllProducts(title: child.name, categoryId: child.id)),
                  ),
                  SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
                  SizedBox(
                    height: 120,
                    child: Builder(builder: (_) {
                      final products = catalog.productsFor(categoryId: child.id);
                      return ListView.separated(
                        separatorBuilder: (_, __) => SizedBox(
                          width: ShopinglySizes.spaceBtwItems,
                        ),
                        itemCount: products.length > 6 ? 6 : products.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => ShopinglyProductCardHorizontal(product: products[index]),
                      );
                    }),
                  ),
                  SizedBox(height: ShopinglySizes.spaceBtwSections),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }
}
