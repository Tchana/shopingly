import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

class BrandModel {
  const BrandModel({
    required this.id,
    required this.name,
    this.image = '',
    this.isFeatured = false,
  });

  final String id;
  final String name;
  final String image;
  final bool isFeatured;

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'isFeatured': isFeatured,
      };

  factory BrandModel.fromMap(String id, Map<String, dynamic> m) => BrandModel(
        id: id,
        name: readString(m, 'name'),
        image: readString(m, 'image'),
        isFeatured: readBool(m, 'isFeatured'),
      );

  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      BrandModel.fromMap(d.id, d.data() ?? const {});
}
