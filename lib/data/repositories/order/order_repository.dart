import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingly_core/shopingly_core.dart';

class OrderRepository {
  final _orders = FirebaseFirestore.instance.collection(Col.orders);

  /// Places the order and returns its new id.
  Future<String> place(OrderModel order) async {
    final doc = await _orders.add({
      ...order.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return doc.id;
  }

  /// Newest first. Sorted here rather than in the query so no composite index is needed.
  Future<List<OrderModel>> forUser(String uid) async {
    final snap = await _orders.where('userId', isEqualTo: uid).get();
    final orders = snap.docs.map(OrderModel.fromSnapshot).toList();
    orders.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
    return orders;
  }

  Future<OrderModel?> get(String id) async {
    final doc = await _orders.doc(id).get();
    return doc.exists ? OrderModel.fromSnapshot(doc) : null;
  }

  /// Customers may only cancel while the order is still pending (enforced by the security rules too).
  Future<void> cancel(String id) {
    return _orders.doc(id).update({
      'status': OrderStatus.cancelled.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
