import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/brands/brand_card.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/screens/brand/brand_products.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(title: Text("Brand"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              ShopinglySectionHeading(title: "Brands", showActionButton: false),
              SizedBox(height: ShopinglySizes.spaceBtwItems),
              ShopinglyGridLayout(
                  itemCount: 10,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) => ShopinglyBrandCard(
                        showBorder: true,
                        onTap: () => Get.to(() => BrandProducts()),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
