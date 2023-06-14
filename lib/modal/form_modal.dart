import 'package:cloud_firestore/cloud_firestore.dart';

class FormModal {
  final String? documentId;
  final String uid;
  final String name;
  final String gender;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final List<Map<String, dynamic>> hobbies;
  final Address address;

  const FormModal({
    this.documentId,
    required this.name,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.hobbies,
    required this.address,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'documentId': documentId,
      'name': name,
      'gender': gender,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'hobbies': hobbies,
      'address': address.toMap(),
    };
  }

  factory FormModal.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return FormModal(
      documentId: doc.id,
      uid: doc.data()?['uid'],
      name: doc.data()?['name'] ?? "",
      gender: doc.data()?['gender'] ?? "",
      email: doc.data()?['email'] ?? "",
      phoneNumber: doc.data()?['phoneNumber'] ?? "",
      dateOfBirth: doc.data()?['dateOfBirth'] ?? "",
      hobbies: doc.data()!['hobbies'] = doc.data()!['hobbies'].cast<Map<String, dynamic>>(),
      address: Address.fromMap(doc.data()?['address'] ?? ""),
    );
  }
}
class Address {
  String addressLine;
  String country;
  String state;
  String city;
  String pinCode;

  Address({
    required this.addressLine,
    required this.country,
    required this.state,
    required this.city,
    required this.pinCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'addressLine': addressLine,
      'country': country,
      'state': state,
      'city': city,
      'pinCode': pinCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      addressLine: map['addressLine'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      pinCode: map['pinCode'] as String,
    );
  }
}
