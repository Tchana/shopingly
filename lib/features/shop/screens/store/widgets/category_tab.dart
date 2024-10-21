import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/brands/brand_show_case.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglyCategoryTab extends StatelessWidget {
  const ShopinglyCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              ShopinglyBrandShowCase(
                images: [
                  ShopinglyImages.product3,
                  ShopinglyImages.product2,
                  ShopinglyImages.product1
                ],
              ),
              SizedBox(height: ShopinglySizes.spaceBtwItems,),

              /// -- Products
              ShopinglySectionHeading(title: "You might like", onPressed: (){},),
              SizedBox(height: ShopinglySizes.spaceBtwItems,),

              ShopinglyGridLayout(itemCount: 4, itemBuilder: (_, index) => ShopinglyProductCardVertical()),
              SizedBox(height: ShopinglySizes.spaceBtwItems,),
            ],
          ),
        ),
      ],
    );
  }
}
