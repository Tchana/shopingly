import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ReviewRepository {
  CollectionReference<Map<String, dynamic>> _reviews(String productId) =>
      FirebaseFirestore.instance.collection(Col.products).doc(productId).collection(Col.reviews);

  /// Newest first.
  Future<List<ReviewModel>> forProduct(String productId) async {
    final snap = await _reviews(productId).get();
    final reviews = snap.docs.map(ReviewModel.fromSnapshot).toList();
    reviews.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
    return reviews;
  }

  /// Creates the customer's review, or edits it. Editing uses update() so the
  /// store's reply (which a customer may not write) is left untouched.
  Future<void> save({
    required String productId,
    required String uid,
    required String userName,
    required double rating,
    required String comment,
    required bool exists,
  }) {
    final doc = _reviews(productId).doc(uid);
    final stamp = FieldValue.serverTimestamp();
    if (exists) {
      return doc.update({'rating': rating, 'comment': comment, 'userName': userName, 'createdAt': stamp});
    }
    return doc.set({
      'productId': productId,
      'userId': uid,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'createdAt': stamp,
    });
  }

  Future<void> delete(String productId, String uid) => _reviews(productId).doc(uid).delete();
}
