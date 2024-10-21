import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/features/shop/screens/order/widgets/order_list.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(
        title:
            Text("My Orders", style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: ShopinglyOrderListItems(),
      ),
    );
  }
}
