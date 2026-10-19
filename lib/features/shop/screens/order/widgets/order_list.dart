import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/order/order_detail.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

Color orderStatusColor(OrderStatus status) => switch (status) {
      OrderStatus.pending => Colors.orange,
      OrderStatus.processing => ShopinglyColors.primaryColor,
      OrderStatus.shipped => Colors.blue,
      OrderStatus.delivered => Colors.green,
      OrderStatus.cancelled => Colors.red,
    };

IconData orderStatusIcon(OrderStatus status) => switch (status) {
      OrderStatus.pending => Iconsax.clock,
      OrderStatus.processing => Iconsax.box,
      OrderStatus.shipped => Iconsax.ship,
      OrderStatus.delivered => Iconsax.tick_circle,
      OrderStatus.cancelled => Iconsax.close_circle,
    };

class ShopinglyOrderListItems extends StatelessWidget {
  const ShopinglyOrderListItems({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final money = CatalogController.instance.settings.value.money;
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (_, __) =>
          SizedBox(height: ShopinglySizes.spaceBtwItems),
      itemCount: orders.length,
      itemBuilder: (_, index) {
        final order = orders[index];
        return GestureDetector(
          onTap: () => Get.to(() => OrderDetailScreen(orderId: order.id)),
          child: ShopinglyRoundedContainer(
            showBorder: true,
            backgroundColor: dark ? ShopinglyColors.dark : ShopinglyColors.light,
            padding: EdgeInsets.all(ShopinglySizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(orderStatusIcon(order.status), color: orderStatusColor(order.status)),
                    SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.status.label,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: orderStatusColor(order.status),
                                  fontWeightDelta: 1,
                                ),
                          ),
                          Text(
                              order.createdAt == null
                                  ? '—'
                                  : ShopinglyHelperFunctions.getFormattedDate(order.createdAt!),
                              style: Theme.of(context).textTheme.headlineSmall),
                        ],
                      ),
                    ),
                    Icon(Iconsax.arrow_right_34, size: ShopinglySizes.iconSm)
                  ],
                ),
                SizedBox(height: ShopinglySizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Iconsax.tag),
                          SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order",
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(order.code,
                                    style: Theme.of(context).textTheme.headlineSmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Iconsax.money),
                          SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${order.itemCount} ${order.itemCount == 1 ? 'item' : 'items'}",
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(money(order.total),
                                    style: Theme.of(context).textTheme.headlineSmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
