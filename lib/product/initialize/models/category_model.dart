import 'package:equatable/equatable.dart';

final class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  CategoryModel copyWith({String? id, String? name}) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
