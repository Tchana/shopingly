import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/brand/brand_products.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(title: Text("Brand"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              ShopinglySectionHeading(title: "Brands", showActionButton: false),
              SizedBox(height: ShopinglySizes.spaceBtwItems),
              Obx(() {
                final brands = [...catalog.brands]..sort((a, b) => a.name.compareTo(b.name));
                if (brands.isEmpty) return const ShopinglyEmptyState(title: 'No brands yet');
                return ShopinglyGridLayout(
                    itemCount: brands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (context, index) => ShopinglyBrandCard(
                          brand: brands[index],
                          showBorder: true,
                          onTap: () => Get.to(() => BrandProducts(brand: brands[index])),
                        ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
