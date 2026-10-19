import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    final catalog = CatalogController.instance;
    return Obx(() {
      final totals = cart.totals;
      final settings = catalog.settings.value;
      Widget line(String label, String value, {TextStyle? style}) => Padding(
            padding: const EdgeInsets.only(bottom: ShopinglySizes.spaceBtwItems / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodyMedium),
                Text(value, style: style ?? Theme.of(context).textTheme.labelLarge),
              ],
            ),
          );
      return Column(
        children: [
          line('Subtotal', settings.money(totals.subtotal), style: Theme.of(context).textTheme.bodyMedium),
          if (totals.discount > 0) line('Discount', '- ${settings.money(totals.discount)}'),
          line('Shipping Fee', totals.shipping == 0 ? 'Free' : settings.money(totals.shipping)),
          line('Tax Fee (${settings.taxPercent.toStringAsFixed(settings.taxPercent % 1 == 0 ? 0 : 2)}%)',
              settings.money(totals.tax)),
          line('Order Total', settings.money(totals.total), style: Theme.of(context).textTheme.titleMedium),
        ],
      );
    });
  }
}
