import 'package:shopingly_core/shopingly_core.dart';

/// A line in the customer's cart. Kept on the device, so it is a plain JSON object.
class CartItemModel {
  CartItemModel({
    required this.productId,
    required this.title,
    required this.image,
    required this.brandName,
    required this.price,
    required this.quantity,
    this.attributes = const {},
  });

  final String productId;
  String title;
  String image;
  String brandName;

  /// Unit price, refreshed from the catalog whenever the cart is opened.
  double price;
  int quantity;
  final Map<String, String> attributes;

  /// Two lines are the same cart entry when product and chosen options match.
  String get key {
    final options = attributes.entries.map((e) => '${e.key}=${e.value}').toList()..sort();
    return '$productId|${options.join(',')}';
  }

  double get lineTotal => roundMoney(price * quantity);

  String get attributesLabel => attributes.entries.map((e) => '${e.key}: ${e.value}').join(' · ');

  OrderItem toOrderItem() => OrderItem(
        productId: productId,
        title: title,
        image: image,
        brandName: brandName,
        price: price,
        quantity: quantity,
        attributes: attributes,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'title': title,
        'image': image,
        'brandName': brandName,
        'price': price,
        'quantity': quantity,
        'attributes': attributes,
      };

  factory CartItemModel.fromJson(Map<String, dynamic> m) => CartItemModel(
        productId: readString(m, 'productId'),
        title: readString(m, 'title'),
        image: readString(m, 'image'),
        brandName: readString(m, 'brandName'),
        price: readDouble(m, 'price'),
        quantity: readInt(m, 'quantity', 1),
        attributes: m['attributes'] is Map
            ? (m['attributes'] as Map).map((k, v) => MapEntry(k.toString(), v.toString()))
            : const {},
      );
}
