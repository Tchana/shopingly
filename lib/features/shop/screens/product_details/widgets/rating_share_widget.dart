import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/controllers/review_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';


class ShopinglyRatingAndShare extends StatelessWidget {
  const ShopinglyRatingAndShare({
    super.key,
    required this.product,
    required this.reviews,
  });

  final ProductModel product;
  final ReviewController reviews;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          final summary = reviews.summary;
          return Row(
            children: [
              Icon(Iconsax.star5, color: Colors.amber, size: 24),
              SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
              Text.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: summary.count == 0 ? 'New ' : '${summary.average.toStringAsFixed(1)} ',
                        style: Theme.of(context).textTheme.bodyLarge),
                    if (summary.count > 0) TextSpan(text: '(${summary.count})')
                  ]
              ))
            ],
          );
        }),
        IconButton(
          onPressed: () async {
            final store = CatalogController.instance.settings.value.storeName;
            await Clipboard.setData(ClipboardData(text: 'Check out ${product.title} on $store!'));
            ShopinglyLoaders.successSnackBar(title: 'Copied', message: 'Share text copied to your clipboard.');
          },
          icon: Icon(Iconsax.share, size: ShopinglySizes.iconMd,),
        ),
      ],
    );
  }
}
