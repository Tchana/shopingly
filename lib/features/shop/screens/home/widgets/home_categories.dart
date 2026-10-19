import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/sub_category/sub_categories.dart';
import 'package:shopingly/utils/constants/colors.dart';


class ShopinglyHomeCategories extends StatelessWidget {
  const ShopinglyHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Obx(() {
      final categories = catalog.homeCategories;
      if (categories.isEmpty) {
        return SizedBox(
          height: 80,
          child: Center(
            child: catalog.isLoading.value
                ? const CircularProgressIndicator(color: ShopinglyColors.white)
                : Text('No categories yet',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(color: ShopinglyColors.white)),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categories[index];
            return ShopinglyVerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
            );
          },
        ),
      );
    });
  }
}
