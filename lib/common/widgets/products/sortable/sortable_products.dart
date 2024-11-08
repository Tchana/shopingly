import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglySortableProducts extends StatelessWidget {
  const ShopinglySortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: [
            "Name",
            "Higher Price",
            "Lower Price",
            "Sale",
            "Newest",
            "Popularity"
          ].map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {},
        ),
        SizedBox(height: ShopinglySizes.spaceBtwSections),
        /// -- Products
        ShopinglyGridLayout(itemCount: 6, itemBuilder: (_, index) => ShopinglyProductCardVertical()),
      ],
    );
  }
}