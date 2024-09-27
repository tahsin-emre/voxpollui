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

  factory PollModel.fromJson(Map<String, dynamic> json, String id) {
    return PollModel(
      id: id,
      ownerId: json['ownerId'] as String,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      categoryId: json['categoryId'] as String?,
      isPublic: json['isPublic'] as bool?,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      endAt: (json['endAt'] as Timestamp?)?.toDate(),
      options: (json['options'] as List<dynamic>?)
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
