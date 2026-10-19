import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, required this.review, this.onDelete});

  final ReviewModel review;

  /// Shown only for the customer's own review.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final isMine = review.userId == FirebaseAuth.instance.currentUser?.uid;
    final initial = review.userName.isEmpty ? '?' : review.userName.characters.first.toUpperCase();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ShopinglyColors.primaryColor,
                    child: Text(initial, style: const TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: ShopinglySizes.spaceBtwItems),
                  Flexible(
                    child: Text(isMine ? '${review.userName} (you)' : review.userName,
                        style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            if (isMine && onDelete != null)
              IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline)),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems),
        Row(
          children: [
            ShopinglyRatingBarIndicator(rating: review.rating),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            Text(
              review.createdAt == null ? '' : ShopinglyHelperFunctions.getFormattedDate(review.createdAt!, format: 'dd MMM, yyyy'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems),
        if (review.comment.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: ReadMoreText(
              review.comment,
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimExpandedText: " show less",
              trimCollapsedText: " show more",
              moreStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ShopinglyColors.primaryColor),
              lessStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ShopinglyColors.primaryColor),
            ),
          ),
        if (review.hasReply) ...[
          SizedBox(height: ShopinglySizes.spaceBtwItems),
          ShopinglyRoundedContainer(
            backgroundColor:
                dark ? ShopinglyColors.darkerGrey : ShopinglyColors.grey,
            child: Padding(
              padding: EdgeInsets.all(ShopinglySizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${CatalogController.instance.settings.value.storeName} Store',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        review.repliedAt == null
                            ? ''
                            : ShopinglyHelperFunctions.getFormattedDate(review.repliedAt!, format: 'dd MMM, yyyy'),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: ShopinglySizes.spaceBtwItems),
                  ReadMoreText(
                    review.storeReply,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimExpandedText: " show less",
                    trimCollapsedText: " show more",
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ShopinglyColors.primaryColor),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ShopinglyColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
        SizedBox(height: ShopinglySizes.spaceBtwSections)
      ],
    );
  }
}
