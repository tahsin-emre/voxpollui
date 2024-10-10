abstract class OwnerModel {
  OwnerModel({
    required this.id,
    required this.ownerType,
    this.name,
    this.userName,
    this.description,
    this.imageUrl,
    this.isPublic,
  });

  final String id;
  final String? name;
  final String? userName;
  final String? description;
  final String? imageUrl;
  final bool? isPublic;
  final OwnerType ownerType;
}

enum OwnerType {
  user,
  community,
}
