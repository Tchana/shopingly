import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profilePicture = '',
    this.createdAt,
  });

  static const empty = UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
  );

  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final DateTime? createdAt;

  String get fullName => '$firstName $lastName'.trim();

  UserModel copyWith({String? firstName, String? lastName, String? username, String? phoneNumber}) => UserModel(
        id: id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        email: email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profilePicture: profilePicture,
        createdAt: createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
      };

  factory UserModel.fromMap(String id, Map<String, dynamic> m) => UserModel(
        id: id,
        firstName: readString(m, 'firstName'),
        lastName: readString(m, 'lastName'),
        username: readString(m, 'username'),
        email: readString(m, 'email'),
        phoneNumber: readString(m, 'phoneNumber'),
        profilePicture: readString(m, 'profilePicture'),
        createdAt: readDate(m, 'createdAt'),
      );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      UserModel.fromMap(d.id, d.data() ?? const {});
}
