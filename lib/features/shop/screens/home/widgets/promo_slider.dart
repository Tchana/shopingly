
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/features/shop/controllers/home_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class ShopinglyPromoSlider extends StatelessWidget {
  const ShopinglyPromoSlider({
    super.key, required this.banners,
  });

  final List<String> banners;
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          items: banners.map((url) => ShopinglyRoundedImage(imageUrl: url)).toList(), options: CarouselOptions(
            viewportFraction: 1,
          onPageChanged: (index, _) => controller.updatePageIndicator(index)
        ),
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems,),
        Obx(
          ()=> Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < banners.length; i++) ShopinglyCircularContainer(
                width: 20,
                height: 4,
                margin: EdgeInsets.only(right: 10),
                backgroundColor: controller.carouselCurrentIndex.value == i ? ShopinglyColors.primaryColor : ShopinglyColors.grey,
              ),
            ],
          ),
        )
      ],
    );
  }
}