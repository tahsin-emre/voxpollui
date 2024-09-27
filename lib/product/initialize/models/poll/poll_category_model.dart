import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class PollCategoryModel extends Equatable {
  const PollCategoryModel({
    required this.id,
    this.name,
  });

  factory PollCategoryModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return PollCategoryModel(
      id: snapshot.id,
      name: data['name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  PollCategoryModel copyWith({String? id, String? name}) {
    return PollCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  final String id;
  final String? name;

  @override
  List<Object?> get props => [id, name];
}
