import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/products/sortable/sortable_products.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Nike"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              ShopinglyBrandCard(showBorder: true),
              SizedBox(height: ShopinglySizes.spaceBtwSections),

              ShopinglySortableProducts()
            ],
          ),
        ),
      ),
    );
  }
}
