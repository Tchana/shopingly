import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';
import 'address_model.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled;

  String get label => switch (this) {
        OrderStatus.pending => 'Pending',
        OrderStatus.processing => 'Processing',
        OrderStatus.shipped => 'Shipped',
        OrderStatus.delivered => 'Delivered',
        OrderStatus.cancelled => 'Cancelled',
      };

  static OrderStatus parse(String value) =>
      OrderStatus.values.firstWhere((s) => s.name == value, orElse: () => OrderStatus.pending);

  /// The statuses an order may move to from this one.
  List<OrderStatus> get next => switch (this) {
        OrderStatus.pending => [OrderStatus.processing, OrderStatus.cancelled],
        OrderStatus.processing => [OrderStatus.shipped, OrderStatus.cancelled],
        OrderStatus.shipped => [OrderStatus.delivered, OrderStatus.cancelled],
        OrderStatus.delivered => const [],
        OrderStatus.cancelled => const [],
      };

  /// Stock is taken out of inventory once an order leaves "pending",
  /// and put back if it is cancelled afterwards.
  bool get holdsStock => this == processing || this == shipped || this == delivered;
}

enum PaymentMethod {
  cashOnDelivery,
  mobileMoney;

  String get label => switch (this) {
        PaymentMethod.cashOnDelivery => 'Cash on delivery',
        PaymentMethod.mobileMoney => 'Mobile money',
      };

  static PaymentMethod parse(String value) =>
      PaymentMethod.values.firstWhere((m) => m.name == value, orElse: () => PaymentMethod.cashOnDelivery);
}

enum PaymentStatus {
  unpaid,
  paid,
  refunded;

  String get label => switch (this) {
        PaymentStatus.unpaid => 'Unpaid',
        PaymentStatus.paid => 'Paid',
        PaymentStatus.refunded => 'Refunded',
      };

  static PaymentStatus parse(String value) =>
      PaymentStatus.values.firstWhere((s) => s.name == value, orElse: () => PaymentStatus.unpaid);
}

/// A snapshot of a product at the moment it was ordered.
class OrderItem {
  const OrderItem({
    required this.productId,
    required this.title,
    this.image = '',
    this.brandName = '',
    required this.price,
    required this.quantity,
    this.attributes = const {},
  });

  final String productId;
  final String title;
  final String image;
  final String brandName;

  /// Unit price actually charged.
  final double price;
  final int quantity;
  final Map<String, String> attributes;

  double get lineTotal => roundMoney(price * quantity);

  String get attributesLabel => attributes.entries.map((e) => '${e.key}: ${e.value}').join(' · ');

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'title': title,
        'image': image,
        'brandName': brandName,
        'price': price,
        'quantity': quantity,
        'attributes': attributes,
      };

  factory OrderItem.fromMap(Map<String, dynamic> m) => OrderItem(
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

class OrderModel {
  const OrderModel({
    required this.id,
    required this.userId,
    this.customerName = '',
    this.customerEmail = '',
    this.status = OrderStatus.pending,
    this.paymentMethod = PaymentMethod.cashOnDelivery,
    this.paymentStatus = PaymentStatus.unpaid,
    required this.items,
    required this.address,
    required this.subtotal,
    this.discount = 0,
    this.shipping = 0,
    this.tax = 0,
    required this.total,
    this.couponCode = '',
    this.note = '',
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;
  final String customerName;
  final String customerEmail;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final List<OrderItem> items;
  final AddressModel address;
  final double subtotal;
  final double discount;
  final double shipping;
  final double tax;
  final double total;
  final String couponCode;
  final String note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Short, human friendly reference shown to customers and staff.
  String get code => '#${id.length >= 6 ? id.substring(0, 6).toUpperCase() : id.toUpperCase()}';

  int get itemCount => items.fold(0, (total, i) => total + i.quantity);

  /// The fields a customer is allowed to set when placing an order.
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'status': status.name,
        'paymentMethod': paymentMethod.name,
        'paymentStatus': paymentStatus.name,
        'items': items.map((i) => i.toJson()).toList(),
        'address': address.toJson(),
        'subtotal': subtotal,
        'discount': discount,
        'shipping': shipping,
        'tax': tax,
        'total': total,
        'couponCode': couponCode,
        'note': note,
      };

  factory OrderModel.fromMap(String id, Map<String, dynamic> m) => OrderModel(
        id: id,
        userId: readString(m, 'userId'),
        customerName: readString(m, 'customerName'),
        customerEmail: readString(m, 'customerEmail'),
        status: OrderStatus.parse(readString(m, 'status')),
        paymentMethod: PaymentMethod.parse(readString(m, 'paymentMethod')),
        paymentStatus: PaymentStatus.parse(readString(m, 'paymentStatus')),
        items: m['items'] is List
            ? (m['items'] as List)
                .whereType<Map>()
                .map((i) => OrderItem.fromMap(Map<String, dynamic>.from(i)))
                .toList()
            : const [],
        address: AddressModel.fromMap('', m['address'] is Map ? Map<String, dynamic>.from(m['address'] as Map) : const {}),
        subtotal: readDouble(m, 'subtotal'),
        discount: readDouble(m, 'discount'),
        shipping: readDouble(m, 'shipping'),
        tax: readDouble(m, 'tax'),
        total: readDouble(m, 'total'),
        couponCode: readString(m, 'couponCode'),
        note: readString(m, 'note'),
        createdAt: readDate(m, 'createdAt'),
        updatedAt: readDate(m, 'updatedAt'),
      );

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      OrderModel.fromMap(d.id, d.data() ?? const {});
}
