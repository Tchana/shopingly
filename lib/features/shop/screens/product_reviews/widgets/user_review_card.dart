import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundImage:
                        AssetImage(ShopinglyImages.userProfileImage1)),
                SizedBox(width: ShopinglySizes.spaceBtwItems),
                Text("John Doe", style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems),
        Row(
          children: [
            ShopinglyRatingBarIndicator(rating: 4.1),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            Text("18 Oct, 2022", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems),
        ReadMoreText(
          "The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly, Great job!",
          trimLines: 1,
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
        SizedBox(height: ShopinglySizes.spaceBtwItems),
        ShopinglyRoundedContainer(
          backgroundColor:
              dark ? ShopinglyColors.darkerGrey : ShopinglyColors.grey,
          child: Padding(
            padding: EdgeInsets.all(ShopinglySizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shopingly Store", style: Theme.of(context).textTheme.titleMedium),
                    Text("19 Oct, 2022", style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),SizedBox(height: ShopinglySizes.spaceBtwItems),
                ReadMoreText(
                  "The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly, Great job!",
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
        SizedBox(height: ShopinglySizes.spaceBtwSections)
      ],
    );
  }
}
