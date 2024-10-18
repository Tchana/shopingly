import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:shopingly/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ShopinglyBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Product image slider
            ShopinglyProductImageSlider(),

            /// -- Product details
            Padding(
              padding: EdgeInsets.only(
                  right: ShopinglySizes.defaultSpace,
                  left: ShopinglySizes.defaultSpace,
                  bottom: ShopinglySizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Ratings and share button
                  ShopinglyRatingAndShare(),
                  /// -- Price, Title, stock and brand
                  ShopinglyProductMetaData(),
                  /// Attributes
                  ShopinglyProductAttributes(),
                  SizedBox(height: ShopinglySizes.spaceBtwSections,),

                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text('Checkout'))),
                  SizedBox(height: ShopinglySizes.spaceBtwSections,),

                  ShopinglySectionHeading(title: 'Description', showActionButton: false,),
                  SizedBox(height: ShopinglySizes.spaceBtwItems),
                  ReadMoreText(
                    "A Flutter plugin that allows for expanding and collapsing text with the added capability to style and interact with specific patterns in the text like hashtags, URLs, and mentions using the new Annotation feature",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: " Less",
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  Divider(),
                  SizedBox(height: ShopinglySizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShopinglySectionHeading(title: "Reviews(199)", showActionButton: false),
                      IconButton(onPressed: () => Get.to(() => ProductReviewsScreen()), icon: Icon(Iconsax.arrow_right_3, size: 18,))
                    ],
                  ),

                  SizedBox(height: ShopinglySizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

