import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/owner_model/owner_model.dart';

final class CommunityModel extends OwnerModel with EquatableMixin {
  CommunityModel({
    required super.id,
    super.name,
    super.userName,
    super.description,
    super.imageUrl,
    super.backgroundUrl,
    super.isPublic,
    this.categoryId,
    this.memberCount,
    this.managerList,
    super.ownerType = OwnerType.community,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json, String id) {
    return CommunityModel(
      id: id,
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      description: json['description'] as String?,
      categoryId: json['categoryId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      backgroundUrl: json['backgroundUrl'] as String?,
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
      'backgroundUrl': backgroundUrl,
      'isPublic': isPublic,
      'categoryId': categoryId,
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
    String? backgroundUrl,
    bool? isPublic,
    String? categoryId,
    num? memberCount,
    List<dynamic>? managerList,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      isPublic: isPublic ?? this.isPublic,
      categoryId: categoryId ?? this.categoryId,
      memberCount: memberCount ?? this.memberCount,
      managerList: managerList ?? this.managerList,
    );
  }

  final num? memberCount;
  final String? categoryId;
  final List<dynamic>? managerList;

  @override
  List<Object?> get props => [
        id,
        name,
        userName,
        description,
        imageUrl,
        backgroundUrl,
        isPublic,
        categoryId,
        memberCount,
        managerList,
      ];
}
