import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/poll/option_model.dart';

final class PollModel extends Equatable {
  const PollModel({
    required this.id,
    required this.ownerId,
    this.title,
    this.imageUrl,
    this.categoryId,
    this.isPublic,
    this.createdAt,
    this.endAt,
    this.options,
  });

  factory PollModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return PollModel(
      id: snapshot.id,
      ownerId: data['ownerId'] as String,
      title: data['title'] as String?,
      imageUrl: data['imageUrl'] as String?,
      categoryId: data['categoryId'] as String?,
      isPublic: data['isPublic'] as bool?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      endAt: (data['endAt'] as Timestamp?)?.toDate(),
      options: (data['options'] as List<dynamic>?)
          ?.map((e) => OptionModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory PollModel.fromDS(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return PollModel(
      id: snapshot.id,
      ownerId: data['ownerId'] as String,
      title: data['title'] as String?,
      imageUrl: data['imageUrl'] as String?,
      categoryId: data['categoryId'] as String?,
      isPublic: data['isPublic'] as bool?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      endAt: (data['endAt'] as Timestamp?)?.toDate(),
      options: (data['options'] as List<dynamic>?)
          ?.map((e) => OptionModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'title': title,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'isPublic': isPublic,
      'createdAt': createdAt,
      'endAt': endAt,
      'options': options?.map((e) => e.toMap()).toList(),
    };
  }

  final String id;
  final String ownerId;
  final String? title;
  final String? imageUrl;
  final String? categoryId;
  final bool? isPublic;
  final DateTime? createdAt;
  final DateTime? endAt;
  final List<OptionModel>? options;

  @override
  List<Object?> get props => [
        id,
        ownerId,
        title,
        imageUrl,
        categoryId,
        isPublic,
        createdAt,
        endAt,
        options,
      ];
}
