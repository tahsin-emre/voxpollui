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
    );
  }

  UserModel copyWith({
    String? phone,
    String? name,
    String? surname,
    String? userName,
    String? email,
  }) {
    return UserModel(
      id: id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'name': name,
      'surname': surname,
      'userName': userName,
      'email': email,
    };
  }

  final String id;
  final String phone;
  final String? name;
  final String? surname;
  final String? userName;
  final String? email;

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
