import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/models/poll/poll_model.dart';

final class PollState extends Equatable {
  const PollState({
    this.pollList,
  });

  PollState copyWith({
    List<PollModel>? pollList,
  }) {
    return PollState(
      pollList: pollList ?? this.pollList,
    );
  }

  final List<PollModel>? pollList;

  @override
  List<Object?> get props => [pollList];
}
