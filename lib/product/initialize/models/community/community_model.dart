import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class CommunityModel extends Equatable {
  const CommunityModel({
    required this.id,
    this.name,
    this.managerList,
    this.memberCount,
  });

  factory CommunityModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return CommunityModel(
      id: snapshot.id,
      name: data['name'] as String?,
      managerList: data['managerList'] as List<dynamic>?,
      memberCount: data['memberCount'] as num?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'managerList': managerList,
      'memberCount': memberCount,
    };
  }

  CommunityModel copyWith({
    String? id,
    String? name,
    List<dynamic>? managerList,
    num? memberCount,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      managerList: managerList ?? this.managerList,
      memberCount: memberCount ?? this.memberCount,
    );
  }

  final String id;
  final String? name;
  final List<dynamic>? managerList;
  final num? memberCount;

  @override
  List<Object?> get props => [id, name, managerList, memberCount];
}
