import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
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
    final cart = CartController.instance;
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
          child: Obx(() {
            final count = cart.count;
            if (count == 0) return const SizedBox.shrink();
            return Container(
              constraints: const BoxConstraints(minWidth: 18),
              height: 18,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  color: ShopinglyColors.black,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: ShopinglyColors.white, fontSizeFactor: 0.8),
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
