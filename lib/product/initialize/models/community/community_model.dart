import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class CommunityModel extends Equatable {
  const CommunityModel({
    required this.id,
    this.name,
    this.managerList,
  });

  factory CommunityModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return CommunityModel(
      id: snapshot.id,
      name: data['name'] as String?,
      managerList: data['managerList'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'managerList': managerList,
    };
  }

  CommunityModel copyWith({
    String? id,
    String? name,
    List<dynamic>? managerList,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      managerList: managerList ?? this.managerList,
    );
  }

  final String id;
  final String? name;
  final List<dynamic>? managerList;

  @override
  List<Object?> get props => [id, name, managerList];
}
