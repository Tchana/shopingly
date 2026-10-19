import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

class ReviewModel {
  const ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.rating,
    this.comment = '',
    this.createdAt,
    this.storeReply = '',
    this.repliedAt,
  });

  /// Equal to [userId]: a customer has at most one review per product.
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime? createdAt;
  final String storeReply;
  final DateTime? repliedAt;

  bool get hasReply => storeReply.isNotEmpty;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'userId': userId,
        'userName': userName,
        'rating': rating,
        'comment': comment,
      };

  factory ReviewModel.fromMap(String id, Map<String, dynamic> m) => ReviewModel(
        id: id,
        productId: readString(m, 'productId'),
        userId: readString(m, 'userId'),
        userName: readString(m, 'userName'),
        rating: readDouble(m, 'rating'),
        comment: readString(m, 'comment'),
        createdAt: readDate(m, 'createdAt'),
        storeReply: readString(m, 'storeReply'),
        repliedAt: readDate(m, 'repliedAt'),
      );

  factory ReviewModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      ReviewModel.fromMap(d.id, d.data() ?? const {});

  /// Average rating and per-star counts (index 0 = 1 star ... 4 = 5 stars).
  static ({double average, int count, List<int> perStar}) summarize(List<ReviewModel> reviews) {
    final perStar = List<int>.filled(5, 0);
    var sum = 0.0;
    for (final r in reviews) {
      sum += r.rating;
      final star = r.rating.round().clamp(1, 5);
      perStar[star - 1]++;
    }
    final count = reviews.length;
    return (average: count == 0 ? 0.0 : sum / count, count: count, perStar: perStar);
  }
}
