import 'package:equatable/equatable.dart';

final class PollModel extends Equatable {
  const PollModel({
    required this.id,
    required this.ownerId,
  });

  final String id;
  final String ownerId;
  @override
  List<Object?> get props => [];
}
