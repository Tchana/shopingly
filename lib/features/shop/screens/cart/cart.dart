import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopingly/features/shop/screens/checkout/checkout.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: ShopinglyCartItems(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: ElevatedButton(onPressed: ()=> Get.to(()=> CheckoutScreen(),), child: Text('Checkout \$300')),
      ),
    );
  }
}
