import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/shop/screens/cart/cart.dart';
import 'package:shopingly/utils/constants/colors.dart';


class ShopinglyCartCounterIcon extends StatelessWidget {
  const ShopinglyCartCounterIcon({
    super.key,
    this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => CartScreen()),
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: ShopinglyColors.black,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: ShopinglyColors.white, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}