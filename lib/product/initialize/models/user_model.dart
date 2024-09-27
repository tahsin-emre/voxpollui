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
      ];
}
