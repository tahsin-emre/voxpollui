import 'package:equatable/equatable.dart';

final class OptionModel extends Equatable {
  const OptionModel({
    required this.id,
    this.optionText,
    this.voteCount,
  });

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      id: map['id'] as String,
      optionText: map['optionText'] as String?,
      voteCount: map['voteCount'] as num?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'optionText': optionText,
      'voteCount': voteCount,
    };
  }

  final String id;
  final String? optionText;
  final num? voteCount;

  @override
  List<Object?> get props => [id, optionText, voteCount];
}
