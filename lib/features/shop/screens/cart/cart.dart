import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopingly/features/shop/screens/checkout/checkout.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/popups/loaders.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Re-price the cart against the latest catalog whenever it is opened.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await CatalogController.instance.load();
      final notes = CartController.instance.syncWithCatalog();
      if (notes.isNotEmpty) {
        ShopinglyLoaders.warningSnackBar(title: 'Your cart was updated', message: notes.join(' '));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    final catalog = CatalogController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return ShopinglyEmptyState(
            icon: Iconsax.shopping_bag,
            title: 'Your cart is empty',
            subtitle: 'Browse the store and add something you like.',
            actionLabel: 'Keep shopping',
            onAction: Get.back,
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
            child: const ShopinglyCartItems(),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (cart.items.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Text('Checkout ${catalog.settings.value.money(cart.subtotal)}'),
          ),
        );
      }),
    );
  }
}
