import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final String gender;
  final DateTime dob;
  final String imageUrl;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.gender,
    required this.dob,
    required this.imageUrl,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? bio,
    String? gender,
    DateTime? dob,
    String? imageUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bio': bio,
      'gender': gender,
      'dob': dob.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      gender: map['gender'] ?? '',
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob']),
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, bio: $bio, gender: $gender, dob: $dob, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.bio == bio &&
        other.gender == gender &&
        other.dob == dob &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        gender.hashCode ^
        dob.hashCode ^
        imageUrl.hashCode;
  }
}
