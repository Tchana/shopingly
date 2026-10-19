import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/controllers/order_controller.dart';
import 'package:shopingly/features/shop/screens/order/widgets/order_list.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// A single order: status, items, totals, delivery address and payment.
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    final money = CatalogController.instance.settings.value.money;
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Obx(() {
      final order = controller.orders.firstWhereOrNull((o) => o.id == orderId);
      if (order == null) {
        return Scaffold(
          appBar: ShopinglyAppBar(title: const Text('Order'), showBackArrow: true),
          body: const Center(child: Text('This order could not be found.')),
        );
      }
      final color = orderStatusColor(order.status);
      return Scaffold(
        appBar: ShopinglyAppBar(
          title: Text('Order ${order.code}', style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- Status
              ShopinglyRoundedContainer(
                backgroundColor: color.withValues(alpha: 0.12),
                padding: EdgeInsets.all(ShopinglySizes.md),
                child: Row(
                  children: [
                    Icon(orderStatusIcon(order.status), color: color, size: 32),
                    SizedBox(width: ShopinglySizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.status.label,
                              style: Theme.of(context).textTheme.titleLarge!.apply(color: color)),
                          Text(
                            order.createdAt == null
                                ? ''
                                : 'Placed on ${ShopinglyHelperFunctions.getFormattedDate(order.createdAt!, format: 'dd MMM yyyy, HH:mm')}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ShopinglySizes.spaceBtwSections),

              /// -- Items
              Text('Items', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: ShopinglySizes.spaceBtwItems),
              for (final item in order.items)
                Padding(
                  padding: const EdgeInsets.only(bottom: ShopinglySizes.spaceBtwItems),
                  child: Row(
                    children: [
                      ShopinglyRoundedImage(
                        imageUrl: item.image,
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.all(ShopinglySizes.sm),
                        backgroundColor: dark ? ShopinglyColors.darkerGrey : ShopinglyColors.light,
                      ),
                      SizedBox(width: ShopinglySizes.spaceBtwItems),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall),
                            if (item.attributes.isNotEmpty)
                              Text(item.attributesLabel, style: Theme.of(context).textTheme.bodySmall),
                            Text('${item.quantity} × ${money(item.price)}',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Text(money(item.lineTotal), style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              Divider(),
              SizedBox(height: ShopinglySizes.spaceBtwItems),

              /// -- Totals
              _line(context, 'Subtotal', money(order.subtotal)),
              if (order.discount > 0)
                _line(context, 'Discount${order.couponCode.isEmpty ? '' : ' (${order.couponCode})'}',
                    '- ${money(order.discount)}'),
              _line(context, 'Shipping', order.shipping == 0 ? 'Free' : money(order.shipping)),
              _line(context, 'Tax', money(order.tax)),
              _line(context, 'Total', money(order.total), bold: true),
              SizedBox(height: ShopinglySizes.spaceBtwSections),

              /// -- Delivery and payment
              Text('Delivery address', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
              Text(order.address.name, style: Theme.of(context).textTheme.bodyLarge),
              Text(order.address.phone, style: Theme.of(context).textTheme.bodyMedium),
              Text(order.address.formatted, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: ShopinglySizes.spaceBtwSections),
              Text('Payment', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
              Text('${order.paymentMethod.label} · ${order.paymentStatus.label}',
                  style: Theme.of(context).textTheme.bodyLarge),

              if (order.status == OrderStatus.pending) ...[
                SizedBox(height: ShopinglySizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _confirmCancel(context, controller, order),
                    child: const Text('Cancel order'),
                  ),
                ),
              ],
              SizedBox(height: ShopinglySizes.spaceBtwSections),
            ],
          ),
        ),
      );
    });
  }

  Widget _line(BuildContext context, String label, String value, {bool bold = false}) => Padding(
        padding: const EdgeInsets.only(bottom: ShopinglySizes.spaceBtwItems / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value, style: bold ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.labelLarge),
          ],
        ),
      );

  Future<void> _confirmCancel(BuildContext context, OrderController controller, OrderModel order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel this order?'),
        content: const Text('Only pending orders can be cancelled.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Keep it')),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Cancel order')),
        ],
      ),
    );
    if (confirmed == true) await controller.cancel(order);
  }
}
