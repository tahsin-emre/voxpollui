import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.phone,
    this.followersCount = 0,
    this.followingCount = 0,
    this.name,
    this.surname,
    this.userName,
    this.email,
    this.imageUrl,
    this.description,
    this.province,
    this.district,
    this.gender,
    this.dateOfBirth,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      phone: json['phone'] as String,
      followersCount: json['followersCount'] as num? ?? 0,
      followingCount: json['followingCount'] as num? ?? 0,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      province: json['province'] as num?,
      district: json['district'] as num?,
      gender: json['gender'] as num?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : (json['dateOfBirth'] as Timestamp).toDate(),
    );
  }

  UserModel copyWith({
    String? phone,
    String? name,
    String? surname,
    String? userName,
    String? description,
    String? email,
    String? imageUrl,
    num? followersCount,
    num? followingCount,
    num? province,
    num? district,
    num? gender,
    DateTime? dateOfBirth,
  }) {
    return UserModel(
      id: id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      province: province ?? this.province,
      district: district ?? this.district,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'name': name,
      'surname': surname,
      'userName': userName,
      'email': email,
      'imageUrl': imageUrl,
      'description': description,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'province': province,
      'district': district,
      'gender': gender,
      'dateOfBirth':
          dateOfBirth != null ? Timestamp.fromDate(dateOfBirth!) : null,
    };
  }

  final String id;
  final String phone;
  final num followersCount;
  final num followingCount;
  final String? name;
  final String? surname;
  final String? userName;
  final String? email;
  final String? imageUrl;
  final String? description;
  final num? province;
  final num? district;
  final num? gender;
  final DateTime? dateOfBirth;

  @override
  List<Object?> get props => [
        id,
        phone,
        name,
        surname,
        userName,
        email,
        imageUrl,
        description,
        followersCount,
        followingCount,
        province,
        district,
        gender,
        dateOfBirth,
      ];
}
