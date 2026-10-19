import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

enum BannerTarget { none, category, brand, product }

class BannerModel {
  const BannerModel({
    required this.id,
    required this.image,
    this.targetType = BannerTarget.none,
    this.targetId = '',
    this.isActive = true,
    this.sortOrder = 0,
  });

  final String id;
  final String image;
  final BannerTarget targetType;
  final String targetId;
  final bool isActive;
  final int sortOrder;

  Map<String, dynamic> toJson() => {
        'image': image,
        'targetType': targetType.name,
        'targetId': targetId,
        'isActive': isActive,
        'sortOrder': sortOrder,
      };

  factory BannerModel.fromMap(String id, Map<String, dynamic> m) => BannerModel(
        id: id,
        image: readString(m, 'image'),
        targetType: BannerTarget.values.firstWhere(
          (t) => t.name == readString(m, 'targetType'),
          orElse: () => BannerTarget.none,
        ),
        targetId: readString(m, 'targetId'),
        isActive: readBool(m, 'isActive', true),
        sortOrder: readInt(m, 'sortOrder'),
      );

  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      BannerModel.fromMap(d.id, d.data() ?? const {});
}
