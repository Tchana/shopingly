import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';

class ShopinglyProductPriceText extends StatelessWidget {
  const ShopinglyProductPriceText({
    super.key, this.currencySign, required this.price, this.maxLines = 1, this.isLarge = false, this.lineThrough = false,
  });

  /// Defaults to the store's currency symbol from the back-office settings.
  final String? currencySign;
  final String price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    final symbol = currencySign ??
        (Get.isRegistered<CatalogController>() ? CatalogController.instance.settings.value.currencySymbol : r'$');
    return Text(
      symbol + price,
      style: isLarge ? Theme.of(context).textTheme.headlineMedium!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
