import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';

/// A friendly message for screens with nothing to show yet.
class ShopinglyEmptyState extends StatelessWidget {
  const ShopinglyEmptyState({
    super.key,
    this.icon = Iconsax.box,
    required this.title,
    this.subtitle = '',
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title, subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).disabledColor),
            const SizedBox(height: ShopinglySizes.spaceBtwItems),
            Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: ShopinglySizes.sm),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
            if (actionLabel != null) ...[
              const SizedBox(height: ShopinglySizes.spaceBtwItems),
              OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Shows a spinner while the catalog loads and a retry prompt if it failed,
/// otherwise builds [builder].
class ShopinglyCatalogGate extends StatelessWidget {
  const ShopinglyCatalogGate({super.key, required this.builder});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Obx(() {
      if (catalog.isLoading.value && catalog.products.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace * 2),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (catalog.loadFailed.value && catalog.products.isEmpty) {
        return ShopinglyEmptyState(
          icon: Iconsax.wifi_square,
          title: "Couldn't load the store",
          subtitle: 'Check your connection and try again.',
          actionLabel: 'Retry',
          onAction: catalog.load,
        );
      }
      return builder(context);
    });
  }
}
