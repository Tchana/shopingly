import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/text_strings.dart';

class ShopinglyHomeAppBar extends StatelessWidget {
  const ShopinglyHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShopinglyAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ShopinglyTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: ShopinglyColors.grey)),
          Text(ShopinglyTexts.homeAppbarSubTitle,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: ShopinglyColors.white))
        ],
      ),
      actions: [
        ShopinglyCartCounterIcon(
          iconColor: ShopinglyColors.white,
        ),
      ],
    );
  }
}