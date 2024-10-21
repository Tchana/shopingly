import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// -- SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal", style: Theme.of(context).textTheme.bodyMedium),
            Text("\$300.0", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        /// -- Shipping Fee
        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping Fee", style: Theme.of(context).textTheme.bodyMedium),
            Text("\$6.0", style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        /// -- Tax Fee
        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tax Fee", style: Theme.of(context).textTheme.bodyMedium),
            Text("\$6.0", style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        /// -- Order Total
        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order Total", style: Theme.of(context).textTheme.bodyMedium),
            Text("\$6.0", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
