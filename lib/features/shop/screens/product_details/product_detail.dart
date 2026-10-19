import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/product_detail_controller.dart';
import 'package:shopingly/features/shop/controllers/review_controller.dart';
import 'package:shopingly/features/shop/screens/cart/cart.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:shopingly/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:shopingly/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // A unique tag gives each opened product page its own state (see the login form for why).
  late final controller = Get.put(ProductDetailController(widget.product), tag: UniqueKey().toString());
  late final reviews = Get.put(ReviewController(widget.product.id), tag: widget.product.id);

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      bottomNavigationBar: ShopinglyBottomAddToCart(controller: controller),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Product image slider
            ShopinglyProductImageSlider(product: product, controller: controller),

            /// -- Product details
            Padding(
              padding: EdgeInsets.only(
                  right: ShopinglySizes.defaultSpace,
                  left: ShopinglySizes.defaultSpace,
                  bottom: ShopinglySizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Ratings and share button
                  ShopinglyRatingAndShare(product: product, reviews: reviews),
                  /// -- Price, Title, stock and brand
                  ShopinglyProductMetaData(product: product),
                  SizedBox(height: ShopinglySizes.spaceBtwItems),
                  /// Attributes
                  ShopinglyProductAttributes(product: product, controller: controller),
                  SizedBox(height: ShopinglySizes.spaceBtwSections,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product.inStock
                          ? () {
                              if (controller.addToCart()) Get.to(() => const CartScreen());
                            }
                          : null,
                      child: Text(product.inStock ? 'Checkout' : 'Out of stock'),
                    ),
                  ),
                  SizedBox(height: ShopinglySizes.spaceBtwSections,),

                  if (product.description.isNotEmpty) ...[
                    ShopinglySectionHeading(title: 'Description', showActionButton: false,),
                    SizedBox(height: ShopinglySizes.spaceBtwItems),
                    ReadMoreText(
                      product.description,
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: " Show more",
                      trimExpandedText: " Less",
                      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ],

                  Divider(),
                  SizedBox(height: ShopinglySizes.spaceBtwItems),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.to(() => ProductReviewsScreen(product: product)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => ShopinglySectionHeading(
                            title: "Reviews(${reviews.summary.count})", showActionButton: false)),
                        IconButton(
                            onPressed: () => Get.to(() => ProductReviewsScreen(product: product)),
                            icon: Icon(Iconsax.arrow_right_3, size: 18,))
                      ],
                    ),
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
