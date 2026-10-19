import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// Reads the public catalog. Everything here is readable without signing in.
class CatalogRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> categories() async {
    final snap = await _db.collection(Col.categories).get();
    return snap.docs.map(CategoryModel.fromSnapshot).toList();
  }

  Future<List<BrandModel>> brands() async {
    final snap = await _db.collection(Col.brands).get();
    return snap.docs.map(BrandModel.fromSnapshot).toList();
  }

  Future<List<BannerModel>> banners() async {
    final snap = await _db.collection(Col.banners).where('isActive', isEqualTo: true).get();
    final banners = snap.docs.map(BannerModel.fromSnapshot).toList();
    banners.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return banners;
  }

  /// Only visible products: the security rules reject queries that could return hidden ones.
  Future<List<ProductModel>> products() async {
    final snap = await _db.collection(Col.products).where('isActive', isEqualTo: true).get();
    return snap.docs.map(ProductModel.fromSnapshot).toList();
  }

  /// Returns null when the product no longer exists or is hidden.
  Future<ProductModel?> product(String id) async {
    try {
      final doc = await _db.collection(Col.products).doc(id).get();
      if (!doc.exists) return null;
      final product = ProductModel.fromSnapshot(doc);
      return product.isActive ? product : null;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') return null;
      rethrow;
    }
  }

  Future<StoreSettings> settings() async {
    final doc = await _db.collection(Col.settings).doc(Col.storeSettingsDoc).get();
    return StoreSettings.fromSnapshot(doc);
  }
}
