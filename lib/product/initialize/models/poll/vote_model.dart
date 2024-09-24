import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class VoteModel extends Equatable {
  const VoteModel({
    required this.id,
    this.optionId,
    this.voteDate,
  });

  factory VoteModel.fromQDS(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return VoteModel(
      id: snapshot.id,
      optionId: data['optionId'] as String?,
      voteDate: (data['voteDate'] as Timestamp?)?.toDate(),
    );
  }

  /// The Vote id is equal to userId
  /// Because the user can vote only once
  final String id;
  final String? optionId;
  final DateTime? voteDate;

  @override
  List<Object?> get props => [id, optionId];
}
