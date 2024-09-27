import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.createdPolls,
    this.participatedPolls,
  });

  ProfileState copyWith({
    bool? isLoading,
    UserModel? user,
    List<PollModel>? createdPolls,
    List<PollModel>? participatedPolls,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      createdPolls: createdPolls ?? this.createdPolls,
      participatedPolls: participatedPolls ?? this.participatedPolls,
    );
  }

  final bool isLoading;
  final UserModel? user;
  final List<PollModel>? createdPolls;
  final List<PollModel>? participatedPolls;

  @override
  List<Object?> get props => [
        isLoading,
        user,
        createdPolls,
        participatedPolls,
      ];
}
