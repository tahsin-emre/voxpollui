import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.phone,
    this.name,
    this.surname,
    this.userName,
    this.email,
    this.followersCount,
    this.followingCount,
  });

  factory UserModel.fromDS(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return UserModel(
      id: snapshot.id,
      phone: data['phone'] as String,
      name: data['name'] as String?,
      surname: data['surname'] as String?,
      userName: data['userName'] as String?,
      email: data['email'] as String?,
      followersCount: data['followersCount'] as num?,
      followingCount: data['followingCount'] as num?,
    );
  }

  UserModel copyWith({
    String? phone,
    String? name,
    String? surname,
    String? userName,
    String? email,
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
      'followersCount': followersCount,
      'followingCount': followingCount,
    };
  }

  final String id;
  final String phone;
  final String? name;
  final String? surname;
  final String? userName;
  final String? email;
  final num? followersCount;
  final num? followingCount;

  @override
  List<Object?> get props => [
        id,
        phone,
        name,
        surname,
        userName,
        email,
      ];
}
