import 'package:equatable/equatable.dart';

final class CommunityModel extends Equatable {
  const CommunityModel({
    required this.id,
    this.name,
    this.categoryId,
    this.imageUrl,
    this.isPublic,
    this.memberCount,
    this.pollCount,
    this.managerList,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json, String id) {
    return CommunityModel(
      id: id,
      name: json['name'] as String?,
      categoryId: json['categoryId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isPublic: json['isPublic'] as bool?,
      memberCount: json['memberCount'] as num?,
      pollCount: json['pollCount'] as num?,
      managerList: json['managerList'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'isPublic': isPublic,
      'memberCount': memberCount,
      'pollCount': pollCount,
      'managerList': managerList,
    };
  }

  CommunityModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? categoryId,
    bool? isPublic,
    num? memberCount,
    num? pollCount,
    List<dynamic>? managerList,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
      isPublic: isPublic ?? this.isPublic,
      memberCount: memberCount ?? this.memberCount,
      pollCount: pollCount ?? this.pollCount,
      managerList: managerList ?? this.managerList,
    );
  }

  final String id;
  final String? name;
  final String? imageUrl;
  final String? categoryId;
  final bool? isPublic;
  final num? memberCount;
  final num? pollCount;
  final List<dynamic>? managerList;

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        imageUrl,
        isPublic,
        memberCount,
        pollCount,
        managerList,
      ];
}
