import 'json_utils.dart';
import 'models/store_settings.dart';

/// Totals shown at checkout and stored on the order.
class OrderTotals {
  const OrderTotals({
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  final double subtotal;
  final double discount;
  final double shipping;
  final double tax;
  final double total;

  static const zero = OrderTotals(subtotal: 0, discount: 0, shipping: 0, tax: 0, total: 0);

  /// Tax is charged on what the customer pays for goods (subtotal minus discount).
  /// An empty cart costs nothing, not even shipping.
  factory OrderTotals.compute({
    required double subtotal,
    required StoreSettings settings,
    double discount = 0,
  }) {
    if (subtotal <= 0) return zero;
    final safeDiscount = discount.clamp(0, subtotal).toDouble();
    final goods = subtotal - safeDiscount;
    final freeShipping = settings.freeShippingOver > 0 && subtotal >= settings.freeShippingOver;
    final shipping = freeShipping ? 0.0 : settings.shippingFee;
    final tax = roundMoney(goods * settings.taxPercent / 100);
    return OrderTotals(
      subtotal: roundMoney(subtotal),
      discount: roundMoney(safeDiscount),
      shipping: roundMoney(shipping),
      tax: tax,
      total: roundMoney(goods + shipping + tax),
    );
  }
}
