import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/texts/product_price_text.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/models/cart_item_model.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ProductQuantityWithAddRemoveButtonVertical extends StatelessWidget {
  const ProductQuantityWithAddRemoveButtonVertical({
    super.key,
    required this.item,
  });

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final cart = CartController.instance;
    return Column(
      children: [
        ShopinglyCircularIcon(
          icon: item.quantity <= 1 ? Iconsax.trash : Iconsax.minus,
          width: 32,
          height: 32,
          size: ShopinglySizes.md,
          color: dark ? ShopinglyColors.white : ShopinglyColors.darkerGrey,
          onPressed: () => cart.decrement(item),
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 5),
        ShopinglyRoundedContainer(
          radius: ShopinglySizes.sm,
          backgroundColor: ShopinglyColors.primaryColor.withValues(alpha: 0.8),
          padding: EdgeInsets.symmetric(
              horizontal: ShopinglySizes.md, vertical: ShopinglySizes.xs),
          child: Row(
            children: [
              Text("(${item.quantity}) ",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: ShopinglyColors.white)),
              ShopinglyProductPriceText(price: item.lineTotal.toStringAsFixed(2)),
            ],
          ),
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 5),
        ShopinglyCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ShopinglySizes.md,
          color: dark ? ShopinglyColors.white : ShopinglyColors.darkerGrey,
          onPressed: () => cart.increment(item),
        ),
      ],
    );
  }
}
