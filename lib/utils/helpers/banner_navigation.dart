import 'package:get/get.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/screens/brand/brand_products.dart';
import 'package:shopingly/features/shop/screens/product_details/product_detail.dart';
import 'package:shopingly/features/shop/screens/sub_category/sub_categories.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// Opens whatever screen a promo banner points at, if it still exists.
void openBannerTarget(BannerModel banner) {
  final catalog = CatalogController.instance;
  switch (banner.targetType) {
    case BannerTarget.category:
      final category = catalog.categoryById(banner.targetId);
      if (category != null) Get.to(() => SubCategoriesScreen(category: category));
    case BannerTarget.brand:
      final brand = catalog.brandById(banner.targetId);
      if (brand != null) Get.to(() => BrandProducts(brand: brand));
    case BannerTarget.product:
      final product = catalog.productById(banner.targetId);
      if (product != null) Get.to(() => ProductDetailScreen(product: product));
    case BannerTarget.none:
      break;
  }
}
