import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class CommunityCategoryModel extends Equatable {
  const CommunityCategoryModel({
    required this.id,
    this.name,
  });

  factory CommunityCategoryModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return CommunityCategoryModel(
      id: snapshot.id,
      name: data['name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  CommunityCategoryModel copyWith({String? id, String? name}) {
    return CommunityCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  final String id;
  final String? name;

  @override
  List<Object?> get props => [id, name];
}
