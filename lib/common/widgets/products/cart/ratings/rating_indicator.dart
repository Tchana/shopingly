import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/utils/constants/colors.dart';

class ShopinglyRatingBarIndicator extends StatelessWidget {
  const ShopinglyRatingBarIndicator({
    super.key, required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: ShopinglyColors.grey,
      itemBuilder: (_, __) => Icon(
        Iconsax.star1,
        color: ShopinglyColors.primaryColor,
      ),
    );
  }
}
