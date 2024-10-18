import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyRatingProgressIndicator extends StatelessWidget {
  const ShopinglyRatingProgressIndicator({
    super.key, required this.text, required this.value,
  });
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        Expanded(
          flex: 11,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 10,
            backgroundColor: ShopinglyColors.grey,
            valueColor: AlwaysStoppedAnimation(ShopinglyColors.primaryColor),
            borderRadius: BorderRadius.circular(7),
          ),
        )
      ],
    );
  }
}