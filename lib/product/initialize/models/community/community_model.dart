import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class CommunityModel extends Equatable {
  const CommunityModel({
    required this.id,
    this.name,
    this.userName,
    this.imageUrl,
    this.managerList,
    this.memberCount,
    this.pollCount,
  });

  factory CommunityModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return CommunityModel(
      id: snapshot.id,
      name: data['name'] as String?,
      userName: data['userName'] as String?,
      imageUrl: data['imageUrl'] as String?,
      managerList: data['managerList'] as List<dynamic>?,
      memberCount: data['memberCount'] as num?,
      pollCount: data['pollCount'] as num?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userName': userName,
      'imageUrl': imageUrl,
      'managerList': managerList,
      'memberCount': memberCount,
      'pollCount': pollCount,
    };
  }

  CommunityModel copyWith({
    String? id,
    String? name,
    String? userName,
    String? imageUrl,
    List<dynamic>? managerList,
    num? memberCount,
    num? pollCount,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      imageUrl: imageUrl ?? this.imageUrl,
      managerList: managerList ?? this.managerList,
      memberCount: memberCount ?? this.memberCount,
      pollCount: pollCount ?? this.pollCount,
    );
  }

  final String id;
  final String? name;
  final String? userName;
  final String? imageUrl;
  final List<dynamic>? managerList;
  final num? memberCount;
  final num? pollCount;

  @override
  List<Object?> get props => [
        id,
        name,
        userName,
        imageUrl,
        managerList,
        memberCount,
        pollCount,
      ];
}
