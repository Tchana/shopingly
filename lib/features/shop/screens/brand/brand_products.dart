import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/products/sortable/sortable_products.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly_core/shopingly_core.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              ShopinglyBrandCard(brand: brand, showBorder: true),
              SizedBox(height: ShopinglySizes.spaceBtwSections),

              Obx(() => ShopinglySortableProducts(
                    products: catalog.productsFor(brandId: brand.id),
                    emptyTitle: 'No ${brand.name} products yet',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
