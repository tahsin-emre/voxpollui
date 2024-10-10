import 'package:equatable/equatable.dart';

final class CommunityModel extends Equatable {
  const CommunityModel({
    required this.id,
    this.name,
    this.userName,
    this.description,
    this.categoryId,
    this.imageUrl,
    this.isPublic,
    this.memberCount,
    this.managerList,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json, String id) {
    return CommunityModel(
      id: id,
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      description: json['description'] as String?,
      categoryId: json['categoryId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isPublic: json['isPublic'] as bool?,
      memberCount: json['memberCount'] as num?,
      managerList: json['managerList'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userName': userName,
      'description': description,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'isPublic': isPublic,
      'memberCount': memberCount,
      'managerList': managerList,
    };
  }

  CommunityModel copyWith({
    String? id,
    String? name,
    String? userName,
    String? description,
    String? imageUrl,
    String? categoryId,
    bool? isPublic,
    num? memberCount,
    List<dynamic>? managerList,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
      isPublic: isPublic ?? this.isPublic,
      memberCount: memberCount ?? this.memberCount,
      managerList: managerList ?? this.managerList,
    );
  }

  final String id;
  final String? name;
  final String? userName;
  final String? description;
  final String? imageUrl;
  final String? categoryId;
  final bool? isPublic;
  final num? memberCount;
  final List<dynamic>? managerList;

  @override
  List<Object?> get props => [
        id,
        name,
        userName,
        description,
        categoryId,
        imageUrl,
        isPublic,
        memberCount,
        managerList,
      ];
}
