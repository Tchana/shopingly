import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/text_strings.dart';

class ShopinglyFormDivider extends StatelessWidget {
  const ShopinglyFormDivider({
    super.key,
    required this.dark, required this.dividerText,
  });

  final String dividerText;

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? ShopinglyColors.darkGrey : ShopinglyColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? ShopinglyColors.darkGrey : ShopinglyColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
