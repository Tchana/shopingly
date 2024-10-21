import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/products/cart/coupon_widget.dart';
import 'package:shopingly/common/widgets/success_screen/success_screen.dart';
import 'package:shopingly/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopingly/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shopingly/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:shopingly/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:shopingly/navigation_menu.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
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
                    BillingPaymentSection(),
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
        child: ElevatedButton(
            onPressed: () => Get.to(
                  () => SuccessScreen(image: ShopinglyImages.successfulPaymentIcon, title: 'Payment Success', subTitle: 'Your Item will be shipped soon!', onPressed: () => Get.offAll(()=>NavigationMenu())),
                ),
            child: Text('Checkout \$300')),
      ),
    );
  }
}
