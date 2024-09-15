import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/models/poll/option_model.dart';

final class PollModel extends Equatable {
  const PollModel({
    required this.id,
    required this.ownerId,
    this.title,
    this.description,
    this.imageUrl,
    this.options,
  });

  factory PollModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return PollModel(
      id: snapshot.id,
      ownerId: data['ownerId'] as String,
      title: data['title'] as String?,
      description: data['description'] as String?,
      imageUrl: data['imageUrl'] as String?,
      options: (data['options'] as List<dynamic>?)
          ?.map((e) => OptionModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final String ownerId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final List<OptionModel>? options;

  @override
  List<Object?> get props => [
        id,
        ownerId,
        title,
        description,
        imageUrl,
        options,
      ];
}
