import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/icons/circular_icon.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/features/shop/screens/home/home.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: ShopinglyAppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ShopinglyCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              ShopinglyGridLayout(itemCount: 6, itemBuilder: (_, index) =>ShopinglyProductCardVertical())
            ],
          ),
        ),
      ),
    );
  }
}
