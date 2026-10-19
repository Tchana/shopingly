import 'package:flutter/material.dart';
import 'package:shopingly/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';

class ShopinglyOverallProductRating extends StatelessWidget {
  const ShopinglyOverallProductRating({
    super.key,
    required this.average,
    required this.perStar,
  });

  /// Average rating, 0 when there are no reviews.
  final double average;

  /// Review counts for 1 to 5 stars (index 0 = 1 star).
  final List<int> perStar;

  @override
  Widget build(BuildContext context) {
    final total = perStar.fold(0, (a, b) => a + b);
    double share(int star) => total == 0 ? 0 : perStar[star - 1] / total;
    return Row(
      children: [
        Expanded(flex: 3, child: Text(average.toStringAsFixed(1), style: Theme.of(context).textTheme.displayLarge)),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              for (final star in [5, 4, 3, 2, 1])
                ShopinglyRatingProgressIndicator(text: '$star', value: share(star)),
            ],
          ),
        )
      ],
    );
  }
}
