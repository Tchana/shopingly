import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

enum CouponType { percent, fixed }

class CouponModel {
  const CouponModel({
    required this.code,
    this.type = CouponType.percent,
    required this.value,
    this.minSubtotal = 0,
    this.isActive = true,
    this.isPublic = false,
    this.expiresAt,
    this.description = '',
  });

  /// Upper-case, and also the Firestore document id.
  final String code;
  final CouponType type;

  /// Percent (0-100) or a fixed amount, depending on [type].
  final double value;
  final double minSubtotal;
  final bool isActive;

  /// Public coupons are listed in the customer's "My Coupons" screen.
  final bool isPublic;
  final DateTime? expiresAt;
  final String description;

  /// Returns a customer-facing reason the coupon cannot be used, or null if it can.
  String? validate(double subtotal, {DateTime? now}) {
    if (!isActive) return 'This coupon is no longer active.';
    if (expiresAt != null && (now ?? DateTime.now()).isAfter(expiresAt!)) {
      return 'This coupon has expired.';
    }
    if (subtotal < minSubtotal) {
      return 'Spend at least ${minSubtotal.toStringAsFixed(2)} to use this coupon.';
    }
    return null;
  }

  /// The amount taken off [subtotal]; never more than the subtotal itself.
  double discountFor(double subtotal) {
    final raw = type == CouponType.percent ? subtotal * value / 100 : value;
    return roundMoney(raw.clamp(0, subtotal).toDouble());
  }

  String get label => type == CouponType.percent ? '${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}% off' : '${value.toStringAsFixed(2)} off';

  Map<String, dynamic> toJson() => {
        'code': code,
        'type': type.name,
        'value': value,
        'minSubtotal': minSubtotal,
        'isActive': isActive,
        'isPublic': isPublic,
        'expiresAt': expiresAt == null ? null : Timestamp.fromDate(expiresAt!),
        'description': description,
      };

  factory CouponModel.fromMap(String id, Map<String, dynamic> m) => CouponModel(
        code: id,
        type: CouponType.values.firstWhere(
          (t) => t.name == readString(m, 'type'),
          orElse: () => CouponType.percent,
        ),
        value: readDouble(m, 'value'),
        minSubtotal: readDouble(m, 'minSubtotal'),
        isActive: readBool(m, 'isActive', true),
        isPublic: readBool(m, 'isPublic'),
        expiresAt: readDate(m, 'expiresAt'),
        description: readString(m, 'description'),
      );

  factory CouponModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      CouponModel.fromMap(d.id, d.data() ?? const {});
}
