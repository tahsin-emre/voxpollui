import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.phone,
    this.name,
  });

  factory UserModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return UserModel(
      id: snapshot.id,
      phone: data['phone'] as String,
      name: data['name'] as String?,
    );
  }

  final String id;
  final String phone;
  final String? name;

  @override
  List<Object?> get props => [id, phone, name];
}
