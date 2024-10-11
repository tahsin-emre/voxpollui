import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/owner_model/owner_model.dart';

final class UserModel extends OwnerModel with EquatableMixin {
  UserModel({
    required super.id,
    super.imageUrl,
    super.description,
    super.userName,
    super.name,
    super.isPublic,
    this.phone,
    this.followersCount = 0,
    this.followingCount = 0,
    this.surname,
    this.email,
    this.province,
    this.district,
    this.gender,
    this.dateOfBirth,
    this.createdAt,
    this.interests,
    super.ownerType = OwnerType.user,
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
      createdAt: json['createdAt'] == null
          ? null
          : (json['createdAt'] as Timestamp).toDate(),
      interests: json['interests'] as List<dynamic>?,
    );
  }

  UserModel copyWith({
    String? name,
    String? userName,
    String? description,
    String? imageUrl,
    bool? isPublic,
    String? phone,
    String? surname,
    String? email,
    num? followersCount,
    num? followingCount,
    num? province,
    num? district,
    num? gender,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    List<dynamic>? interests,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
      phone: phone ?? this.phone,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      province: province ?? this.province,
      district: district ?? this.district,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      interests: interests ?? this.interests,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userName': userName,
      'imageUrl': imageUrl,
      'description': description,
      'isPublic': isPublic,
      'phone': phone,
      'surname': surname,
      'email': email,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'province': province,
      'district': district,
      'gender': gender,
      'dateOfBirth':
          dateOfBirth != null ? Timestamp.fromDate(dateOfBirth!) : null,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'interests': interests,
    };
  }

  final num followersCount;
  final num followingCount;
  final String? phone;
  final String? surname;
  final String? email;
  final num? province;
  final num? district;
  final num? gender;
  final DateTime? dateOfBirth;
  final DateTime? createdAt;
  final List<dynamic>? interests;

  @override
  List<Object?> get props => [
        id,
        name,
        userName,
        imageUrl,
        description,
        isPublic,
        phone,
        surname,
        email,
        followersCount,
        followingCount,
        province,
        district,
        gender,
        dateOfBirth,
        createdAt,
        interests,
      ];
}
