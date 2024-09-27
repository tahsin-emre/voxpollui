import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.polls,
  });

  ProfileState copyWith({
    bool? isLoading,
    UserModel? user,
    List<PollModel>? polls,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      polls: polls ?? this.polls,
    );
  }

  final bool isLoading;
  final UserModel? user;
  final List<PollModel>? polls;

  @override
  List<Object?> get props => [
        isLoading,
        user,
        polls,
      ];
}
