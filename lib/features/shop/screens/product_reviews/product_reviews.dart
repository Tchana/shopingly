import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/products/cart/ratings/rating_indicator.dart';
import 'package:shopingly/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:shopingly/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Reviews & Ratings"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Ratings and reviews are verified and are from people who use the same type of device that you use."),
              SizedBox(height: ShopinglySizes.spaceBtwItems),
              ShopinglyOverallProductRating(),
              ShopinglyRatingBarIndicator(rating: 3.4),
              Text("12,925", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: ShopinglySizes.spaceBtwSections),

              /// -- User Reviews List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}