import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopingly_core/shopingly_core.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _users = FirebaseFirestore.instance.collection(Col.users);

  Future<void> saveUserRecord(UserModel user) {
    return _users.doc(user.id).set({
      ...user.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Returns [UserModel.empty] when the user has no Firestore record.
  Future<UserModel> fetchUserDetails(String uid) async {
    final doc = await _users.doc(uid).get();
    return doc.exists ? UserModel.fromSnapshot(doc) : UserModel.empty;
  }

  Future<void> updateUserFields(String uid, Map<String, dynamic> fields) {
    return _users.doc(uid).update(fields);
  }

  /// Removes the profile and its saved addresses. Orders are kept for the store's records.
  Future<void> deleteUserData(String uid) async {
    final addresses = await _users.doc(uid).collection(Col.addresses).get();
    final batch = FirebaseFirestore.instance.batch();
    for (final doc in addresses.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(_users.doc(uid));
    await batch.commit();
  }
}
