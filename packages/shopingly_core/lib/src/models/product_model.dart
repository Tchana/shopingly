import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

/// A selectable option group such as Color (Red, Blue) or Size (S, M, L).
class ProductAttribute {
  const ProductAttribute({required this.name, required this.values});

  final String name;
  final List<String> values;

  Map<String, dynamic> toJson() => {'name': name, 'values': values};

  factory ProductAttribute.fromMap(Map<String, dynamic> m) =>
      ProductAttribute(name: readString(m, 'name'), values: readStringList(m, 'values'));
}

class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    this.description = '',
    this.sku = '',
    required this.price,
    this.salePrice = 0,
    this.stock = 0,
    this.sold = 0,
    this.thumbnail = '',
    this.images = const [],
    this.brandId = '',
    this.brandName = '',
    this.brandImage = '',
    this.categoryId = '',
    this.categoryIds = const [],
    this.isFeatured = false,
    this.isActive = true,
    this.attributes = const [],
    this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String sku;
  final double price;

  /// 0 (or anything not below [price]) means the product is not on sale.
  final double salePrice;
  final int stock;
  final int sold;
  final String thumbnail;
  final List<String> images;
  final String brandId;
  final String brandName;
  final String brandImage;

  /// The most specific category, and that category plus all its ancestors.
  /// Queries use [categoryIds] with array-contains so a top-level category
  /// also lists the products of its sub-categories.
  final String categoryId;
  final List<String> categoryIds;
  final bool isFeatured;
  final bool isActive;
  final List<ProductAttribute> attributes;
  final DateTime? createdAt;

  bool get isOnSale => salePrice > 0 && salePrice < price;
  double get effectivePrice => isOnSale ? salePrice : price;
  int get discountPercent => isOnSale ? (((price - salePrice) / price) * 100).round() : 0;
  bool get inStock => stock > 0;

  /// Thumbnail first, then the gallery, without duplicates.
  List<String> get gallery {
    final all = <String>[if (thumbnail.isNotEmpty) thumbnail, ...images];
    return all.toSet().toList();
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'sku': sku,
        'price': price,
        'salePrice': salePrice,
        'stock': stock,
        'sold': sold,
        'thumbnail': thumbnail,
        'images': images,
        'brandId': brandId,
        'brandName': brandName,
        'brandImage': brandImage,
        'categoryId': categoryId,
        'categoryIds': categoryIds,
        'isFeatured': isFeatured,
        'isActive': isActive,
        'attributes': attributes.map((a) => a.toJson()).toList(),
      };

  factory ProductModel.fromMap(String id, Map<String, dynamic> m) => ProductModel(
        id: id,
        title: readString(m, 'title'),
        description: readString(m, 'description'),
        sku: readString(m, 'sku'),
        price: readDouble(m, 'price'),
        salePrice: readDouble(m, 'salePrice'),
        stock: readInt(m, 'stock'),
        sold: readInt(m, 'sold'),
        thumbnail: readString(m, 'thumbnail'),
        images: readStringList(m, 'images'),
        brandId: readString(m, 'brandId'),
        brandName: readString(m, 'brandName'),
        brandImage: readString(m, 'brandImage'),
        categoryId: readString(m, 'categoryId'),
        categoryIds: readStringList(m, 'categoryIds'),
        isFeatured: readBool(m, 'isFeatured'),
        isActive: readBool(m, 'isActive', true),
        attributes: (m['attributes'] is List)
            ? (m['attributes'] as List)
                .whereType<Map>()
                .map((a) => ProductAttribute.fromMap(Map<String, dynamic>.from(a)))
                .toList()
            : const [],
        createdAt: readDate(m, 'createdAt'),
      );

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      ProductModel.fromMap(d.id, d.data() ?? const {});
}
