import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/features/shop/controllers/order_controller.dart';
import 'package:shopingly/features/shop/screens/order/widgets/order_list.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    // Always show the latest status when the page is opened.
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.fetch());
    return Scaffold(
      appBar: ShopinglyAppBar(
        title:
            Text("My Orders", style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetch,
        child: Obx(() {
          if (controller.isLoading.value && controller.orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.orders.isEmpty) {
            return ListView(
              children: [
                SizedBox(
                  height: 400,
                  child: ShopinglyEmptyState(
                    icon: Iconsax.bag_tick,
                    title: 'No orders yet',
                    subtitle: 'When you place an order it will show up here.',
                    actionLabel: 'Start shopping',
                    onAction: Get.back,
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
            child: ShopinglyOrderListItems(orders: controller.orders.toList()),
          );
        }),
      ),
    );
  }
}
