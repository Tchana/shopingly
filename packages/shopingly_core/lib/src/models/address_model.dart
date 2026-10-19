import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

class AddressModel {
  const AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.street,
    this.postalCode = '',
    required this.city,
    this.state = '',
    required this.country,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final String phone;
  final String street;
  final String postalCode;
  final String city;
  final String state;
  final String country;
  final bool isSelected;

  String get formatted => [street, city, state, postalCode, country]
      .where((p) => p.trim().isNotEmpty)
      .join(', ');

  AddressModel copyWith({bool? isSelected}) => AddressModel(
        id: id,
        name: name,
        phone: phone,
        street: street,
        postalCode: postalCode,
        city: city,
        state: state,
        country: country,
        isSelected: isSelected ?? this.isSelected,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'street': street,
        'postalCode': postalCode,
        'city': city,
        'state': state,
        'country': country,
        'isSelected': isSelected,
      };

  factory AddressModel.fromMap(String id, Map<String, dynamic> m) => AddressModel(
        id: id,
        name: readString(m, 'name'),
        phone: readString(m, 'phone'),
        street: readString(m, 'street'),
        postalCode: readString(m, 'postalCode'),
        city: readString(m, 'city'),
        state: readString(m, 'state'),
        country: readString(m, 'country'),
        isSelected: readBool(m, 'isSelected'),
      );

  factory AddressModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      AddressModel.fromMap(d.id, d.data() ?? const {});
}
