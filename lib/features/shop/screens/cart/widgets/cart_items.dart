import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/products/cart/add_remove_button.dart';
import 'package:shopingly/common/widgets/products/cart/cart_item.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglyCartItems extends StatelessWidget {
  const ShopinglyCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: showAddRemoveButtons ? null : const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => SizedBox(
          height: ShopinglySizes.spaceBtwSections,
        ),
        itemCount: cart.items.length,
        itemBuilder: (_, index) {
          final item = cart.items[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// -- Image
              ShopinglyCartItem(item: item),
              if (showAddRemoveButtons)
                SizedBox(
                  width: ShopinglySizes.spaceBtwItems,
                ),

              /// -- Add or Remove buttons (or just the line total on the checkout page)
              if (showAddRemoveButtons)
                ProductQuantityWithAddRemoveButtonVertical(item: item)
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('× ${item.quantity}', style: Theme.of(context).textTheme.labelLarge),
                    ShopinglyProductPriceText(price: item.lineTotal.toStringAsFixed(2)),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
