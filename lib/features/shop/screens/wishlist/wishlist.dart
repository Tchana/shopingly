import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/features/shop/controllers/wishlist_controller.dart';
import 'package:shopingly/features/shop/screens/all_products/all_products.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ShopinglyCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(() => const AllProducts()),
          )
        ],
      ),
      body: Obx(() {
        final products = wishlist.products;
        if (products.isEmpty) {
          return ShopinglyEmptyState(
            icon: Iconsax.heart,
            title: 'Your wishlist is empty',
            subtitle: 'Tap the heart on any product to save it here.',
            actionLabel: 'Browse products',
            onAction: () => Get.to(() => const AllProducts()),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
            child: ShopinglyGridLayout(
              itemCount: products.length,
              itemBuilder: (_, index) => ShopinglyProductCardVertical(product: products[index]),
            ),
          ),
        );
      }),
    );
  }
}
