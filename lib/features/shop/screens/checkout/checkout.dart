import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/products/cart/coupon_widget.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/controllers/checkout_controller.dart';
import 'package:shopingly/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopingly/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shopingly/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:shopingly/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());
    final cart = CartController.instance;
    final catalog = CatalogController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Order Review",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              /// -- Items in cart
              ShopinglyCartItems(
                showAddRemoveButtons: false,
              ),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),

              /// -- Coupon TextField
              ShopinglyCouponCode(),
              SizedBox(
                height: ShopinglySizes.spaceBtwSections,
              ),

              /// -- Billing Section
              ShopinglyRoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(ShopinglySizes.md),
                backgroundColor:
                    dark ? ShopinglyColors.black : ShopinglyColors.white,
                child: Column(
                  children: [
                    BillingAmountSection(),
                    SizedBox(height: ShopinglySizes.spaceBtwItems),
                    Divider(),
                    SizedBox(height: ShopinglySizes.spaceBtwItems),
                    BillingPaymentSection(controller: controller),
                    SizedBox(height: ShopinglySizes.spaceBtwItems),
                    BillingAddressSection(),
                    SizedBox(height: ShopinglySizes.spaceBtwItems),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: Obx(
          () => ElevatedButton(
            onPressed: controller.isPlacing.value || cart.items.isEmpty ? null : controller.placeOrder,
            child: controller.isPlacing.value
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text('Place order · ${catalog.settings.value.money(cart.totals.total)}'),
          ),
        ),
      ),
    );
  }
}
