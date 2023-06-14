class UserModal {
  final String name;
  final String uid;
  final String email;
  final String phoneNumber;

  const UserModal({
    this.name = '',
    this.uid = '',
    this.email = '',
    this.phoneNumber = '',
  });

  UserModal copyWith({
    String? name,
    String? uid,
    String? email,
    String? phoneNumber,
  }) {
    return UserModal(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      name: map['name'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }
}
