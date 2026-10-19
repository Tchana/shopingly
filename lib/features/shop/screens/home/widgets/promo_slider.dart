import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shopingly/common/widgets/images/shopingly_rounded_image.dart';
import 'package:shopingly/features/shop/controllers/home_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/banner_navigation.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglyPromoSlider extends StatelessWidget {
  const ShopinglyPromoSlider({
    super.key, required this.banners,
  });

  final List<BannerModel> banners;

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox.shrink();
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          items: banners
              .map((banner) => ShopinglyRoundedImage(
                    imageUrl: banner.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    onPressed: () => openBannerTarget(banner),
                  ))
              .toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: banners.length > 1,
              onPageChanged: (index, _) => controller.updatePageIndicator(index)),
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
