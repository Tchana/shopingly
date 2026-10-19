import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    this.image = '',
    this.parentId = '',
    this.isFeatured = false,
  });

  final String id;
  final String name;

  /// An `assets/...` path bundled in an app, or an `https://` URL.
  final String image;

  /// Empty for a top-level category.
  final String parentId;
  final bool isFeatured;

  bool get isTopLevel => parentId.isEmpty;

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'parentId': parentId,
        'isFeatured': isFeatured,
      };

  factory CategoryModel.fromMap(String id, Map<String, dynamic> m) => CategoryModel(
        id: id,
        name: readString(m, 'name'),
        image: readString(m, 'image'),
        parentId: readString(m, 'parentId'),
        isFeatured: readBool(m, 'isFeatured'),
      );

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      CategoryModel.fromMap(d.id, d.data() ?? const {});
}
