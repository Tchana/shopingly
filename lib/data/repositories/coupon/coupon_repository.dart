import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingly_core/shopingly_core.dart';

class CouponRepository {
  final _coupons = FirebaseFirestore.instance.collection(Col.coupons);

  /// Looks up a code the customer typed. Null if it does not exist.
  Future<CouponModel?> byCode(String code) async {
    final doc = await _coupons.doc(code.trim().toUpperCase()).get();
    return doc.exists ? CouponModel.fromSnapshot(doc) : null;
  }

  /// Coupons the store chose to advertise.
  Future<List<CouponModel>> publicCoupons() async {
    final snap = await _coupons.where('isPublic', isEqualTo: true).get();
    final now = DateTime.now();
    return snap.docs
        .map(CouponModel.fromSnapshot)
        .where((c) => c.isActive && (c.expiresAt == null || c.expiresAt!.isAfter(now)))
        .toList();
  }
}
