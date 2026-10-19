import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/products/sortable/sortable_products.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';

/// Every product, or just one category's when [categoryId] is given.
class AllProducts extends StatelessWidget {
  const AllProducts({super.key, this.title = 'Popular Products', this.categoryId});

  final String title;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Obx(() => ShopinglySortableProducts(products: catalog.productsFor(categoryId: categoryId))),
        ),
      ),
    );
  }
}
