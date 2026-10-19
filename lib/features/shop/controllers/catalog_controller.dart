import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/catalog/catalog_repository.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly_core/shopingly_core.dart';

enum ProductSort {
  name('Name'),
  priceHigh('Higher Price'),
  priceLow('Lower Price'),
  sale('Sale'),
  newest('Newest'),
  popularity('Popularity');

  const ProductSort(this.label);
  final String label;

  List<ProductModel> apply(List<ProductModel> products) {
    final list = [...products];
    int byDate(ProductModel a, ProductModel b) =>
        (b.createdAt ?? DateTime(2000)).compareTo(a.createdAt ?? DateTime(2000));
    switch (this) {
      case ProductSort.name:
        list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      case ProductSort.priceHigh:
        list.sort((a, b) => b.effectivePrice.compareTo(a.effectivePrice));
      case ProductSort.priceLow:
        list.sort((a, b) => a.effectivePrice.compareTo(b.effectivePrice));
      case ProductSort.sale:
        list.sort((a, b) => b.discountPercent.compareTo(a.discountPercent));
      case ProductSort.newest:
        list.sort(byDate);
      case ProductSort.popularity:
        list.sort((a, b) => b.sold.compareTo(a.sold));
    }
    return list;
  }
}

/// Holds the public catalog (categories, brands, banners, products, store settings)
/// in memory so browsing, filtering and searching are instant.
class CatalogController extends GetxController with WidgetsBindingObserver {
  static CatalogController get instance => Get.find();

  final _repository = CatalogRepository();

  final categories = <CategoryModel>[].obs;
  final brands = <BrandModel>[].obs;
  final banners = <BannerModel>[].obs;
  final products = <ProductModel>[].obs;
  final settings = StoreSettings.defaults.obs;

  final isLoading = true.obs;
  final loadFailed = false.obs;

  DateTime? _lastLoaded;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    load();
  }

  /// Stock and prices change in the back office, so refresh when the customer comes back to the app.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final stale = _lastLoaded == null || DateTime.now().difference(_lastLoaded!) > const Duration(minutes: 1);
    if (state == AppLifecycleState.resumed && stale && !isLoading.value) load();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  Future<void> load() async {
    isLoading.value = true;
    loadFailed.value = false;
    try {
      final results = await Future.wait([
        _repository.categories(),
        _repository.brands(),
        _repository.banners(),
        _repository.products(),
        _repository.settings(),
      ]);
      categories.assignAll(results[0] as List<CategoryModel>);
      brands.assignAll(results[1] as List<BrandModel>);
      banners.assignAll(results[2] as List<BannerModel>);
      products.assignAll(results[3] as List<ProductModel>);
      settings.value = results[4] as StoreSettings;
      _lastLoaded = DateTime.now();
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not load the catalog', e);
      loadFailed.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  // ---- Categories
  List<CategoryModel> get topCategories =>
      categories.where((c) => c.isTopLevel).toList()..sort((a, b) => a.name.compareTo(b.name));

  /// Featured categories for the home screen; falls back to all top-level ones.
  List<CategoryModel> get homeCategories {
    final featured = categories.where((c) => c.isFeatured).toList();
    return featured.isNotEmpty ? featured : topCategories;
  }

  List<CategoryModel> childrenOf(String id) =>
      categories.where((c) => c.parentId == id).toList()..sort((a, b) => a.name.compareTo(b.name));

  CategoryModel? categoryById(String id) {
    for (final c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }

  // ---- Brands
  List<BrandModel> get featuredBrands {
    final featured = brands.where((b) => b.isFeatured).toList();
    return featured.isNotEmpty ? featured : brands.toList();
  }

  BrandModel? brandById(String id) {
    for (final b in brands) {
      if (b.id == id) return b;
    }
    return null;
  }

  int productCountForBrand(String brandId) => products.where((p) => p.brandId == brandId).length;

  // ---- Products
  ProductModel? productById(String id) {
    for (final p in products) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Featured products first, then the newest, so the home screen is never empty.
  List<ProductModel> popularProducts({int limit = 8}) {
    final featured = products.where((p) => p.isFeatured).toList();
    final rest = ProductSort.newest.apply(products.where((p) => !p.isFeatured).toList());
    return [...featured, ...rest].take(limit).toList();
  }

  /// Products in a category (including its sub-categories) and/or brand,
  /// optionally filtered by a search [query].
  List<ProductModel> productsFor({String? categoryId, String? brandId, String query = ''}) {
    final q = query.trim().toLowerCase();
    return products.where((p) {
      if (categoryId != null && !p.categoryIds.contains(categoryId) && p.categoryId != categoryId) return false;
      if (brandId != null && p.brandId != brandId) return false;
      if (q.isEmpty) return true;
      return p.title.toLowerCase().contains(q) ||
          p.brandName.toLowerCase().contains(q) ||
          p.sku.toLowerCase().contains(q);
    }).toList();
  }

  /// Brands that have at least one product in [categoryId].
  List<BrandModel> brandsInCategory(String categoryId) {
    final ids = productsFor(categoryId: categoryId).map((p) => p.brandId).toSet();
    return brands.where((b) => ids.contains(b.id)).toList();
  }
}
