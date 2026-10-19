import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingly_core/shopingly_core.dart';

class AddressRepository {
  CollectionReference<Map<String, dynamic>> _addresses(String uid) =>
      FirebaseFirestore.instance.collection(Col.users).doc(uid).collection(Col.addresses);

  Future<List<AddressModel>> fetch(String uid) async {
    final snap = await _addresses(uid).get();
    return snap.docs.map(AddressModel.fromSnapshot).toList();
  }

  Future<String> add(String uid, AddressModel address) async {
    final doc = await _addresses(uid).add(address.toJson());
    return doc.id;
  }

  Future<void> delete(String uid, String id) => _addresses(uid).doc(id).delete();

  /// Marks one address as the shipping address and clears the flag on the others.
  Future<void> select(String uid, String id, List<AddressModel> all) {
    final batch = FirebaseFirestore.instance.batch();
    for (final a in all) {
      final shouldBeSelected = a.id == id;
      if (a.isSelected != shouldBeSelected) {
        batch.update(_addresses(uid).doc(a.id), {'isSelected': shouldBeSelected});
      }
    }
    return batch.commit();
  }
}
