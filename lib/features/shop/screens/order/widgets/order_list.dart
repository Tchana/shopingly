import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyOrderListItems extends StatelessWidget {
  const ShopinglyOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) =>
          SizedBox(height: ShopinglySizes.spaceBtwItems),
      itemCount: 2,
      itemBuilder: (_, index) => ShopinglyRoundedContainer(
        showBorder: true,
        backgroundColor: dark ? ShopinglyColors.dark : ShopinglyColors.light,
        padding: EdgeInsets.all(ShopinglySizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Iconsax.ship),
                SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Processing",
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: ShopinglyColors.primaryColor,
                              fontWeightDelta: 1,
                            ),
                      ),
                      Text("21 Oct 2022",
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.arrow_right_34,
                        size: ShopinglySizes.iconSm))
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
                            Text("[#256F2]",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Iconsax.calendar),
                      SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shipping Date",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text("30 Oct 2022",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
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
  }
}
