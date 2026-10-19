import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shopingly/features/shop/controllers/review_controller.dart';
import 'package:shopingly/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:shopingly/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ReviewController.of(product.id);
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Reviews & Ratings"),
        showBackArrow: true,
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton.extended(
          backgroundColor: ShopinglyColors.primaryColor,
          foregroundColor: ShopinglyColors.white,
          onPressed: () => _showReviewSheet(context, controller),
          icon: const Icon(Iconsax.edit),
          label: Text(controller.mine == null ? 'Write a review' : 'Edit your review'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetch,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
            child: Obx(() {
              if (controller.isLoading.value && controller.reviews.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(ShopinglySizes.defaultSpace * 2),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final summary = controller.summary;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: ShopinglySizes.spaceBtwItems),
                  ShopinglyOverallProductRating(average: summary.average, perStar: summary.perStar),
                  ShopinglyRatingBarIndicator(rating: summary.average),
                  Text("${summary.count} ${summary.count == 1 ? 'review' : 'reviews'}",
                      style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height: ShopinglySizes.spaceBtwSections),

                  /// -- User Reviews List
                  if (controller.reviews.isEmpty)
                    const ShopinglyEmptyState(
                      icon: Iconsax.star,
                      title: 'No reviews yet',
                      subtitle: 'Be the first to share what you think.',
                    )
                  else
                    for (final review in controller.reviews)
                      UserReviewCard(
                        review: review,
                        onDelete: () => _confirmDelete(context, controller),
                      ),
                  const SizedBox(height: 72),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, ReviewController controller) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete your review?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) await controller.deleteMine();
  }

  Future<void> _showReviewSheet(BuildContext context, ReviewController controller) {
    final existing = controller.mine;
    var rating = existing?.rating ?? 0;
    final comment = TextEditingController(text: existing?.comment ?? '');
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: ShopinglySizes.defaultSpace,
          right: ShopinglySizes.defaultSpace,
          top: ShopinglySizes.defaultSpace,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + ShopinglySizes.defaultSpace,
        ),
        child: StatefulBuilder(
          builder: (_, setSheetState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(existing == null ? 'Rate this product' : 'Edit your review',
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: ShopinglySizes.spaceBtwItems),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                itemSize: 36,
                glow: false,
                itemBuilder: (_, __) => const Icon(Iconsax.star1, color: ShopinglyColors.primaryColor),
                onRatingUpdate: (value) => setSheetState(() => rating = value),
              ),
              SizedBox(height: ShopinglySizes.spaceBtwItems),
              TextField(
                controller: comment,
                maxLines: 4,
                maxLength: 1000,
                decoration: const InputDecoration(hintText: 'Tell others what you think (optional)'),
              ),
              SizedBox(height: ShopinglySizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: rating < 1 || controller.isSaving.value
                        ? null
                        : () async {
                            final ok = await controller.submit(rating: rating, comment: comment.text);
                            if (ok && sheetContext.mounted) Navigator.of(sheetContext).pop();
                          },
                    child: controller.isSaving.value
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(comment.dispose);
  }
}
