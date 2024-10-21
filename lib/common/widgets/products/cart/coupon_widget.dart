import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyCouponCode extends StatelessWidget {
  const ShopinglyCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return ShopinglyRoundedContainer(
      showBorder: true,
      backgroundColor:
      dark ? ShopinglyColors.dark : ShopinglyColors.white,
      padding: EdgeInsets.only(
          top: ShopinglySizes.sm,
          bottom: ShopinglySizes.sm,
          right: ShopinglySizes.sm,
          left: ShopinglySizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Have a promo code? Enter here",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? ShopinglyColors.white.withOpacity(0.5)
                    : ShopinglyColors.dark.withOpacity(0.5),
                backgroundColor: ShopinglyColors.grey.withOpacity(0.2),
                side: BorderSide(color: ShopinglyColors.grey.withOpacity(0.1),),
              ),
              child: Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}