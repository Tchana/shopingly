import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/products/cart/add_remove_button.dart';
import 'package:shopingly/common/widgets/products/cart/cart_item.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglyCartItems extends StatelessWidget {
  const ShopinglyCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(
        height: ShopinglySizes.spaceBtwSections,
      ),
      itemCount: 2,
      itemBuilder: (_, index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// -- Image
          ShopinglyCartItem(),
          if(showAddRemoveButtons) SizedBox(
            width: ShopinglySizes.spaceBtwItems,
          ),

          /// -- Add or Remove buttons
          if(showAddRemoveButtons) ProductQuantityWithAddRemoveButtonVertical(),
        ],
      ),
    );
  }
}
