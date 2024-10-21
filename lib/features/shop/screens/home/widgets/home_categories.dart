import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:shopingly/features/shop/screens/sub_category/sub_categories.dart';
import 'package:shopingly/utils/constants/image_strings.dart';


class ShopinglyHomeCategories extends StatelessWidget {
  const ShopinglyHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return ShopinglyVerticalImageText(
            image: ShopinglyImages.shoeIcon,
            title: 'Shoes',
            onTap: () => Get.to(()=>SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}