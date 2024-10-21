import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';

final class DiscoverState extends Equatable {
  const DiscoverState({
    this.users,
    this.communities,
    this.polls,
    this.query,
    this.isLoading = false,
  });

  DiscoverState copyWith({
    List<UserModel>? users,
    List<CommunityModel>? communities,
    List<PollModel>? polls,
    String? query,
    bool? isLoading,
  }) {
    return DiscoverState(
      users: users ?? this.users,
      communities: communities ?? this.communities,
      polls: polls ?? this.polls,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<UserModel>? users;
  final List<CommunityModel>? communities;
  final List<PollModel>? polls;
  final String? query;
  final bool isLoading;

  @override
  List<Object?> get props => [users, communities, polls, query, isLoading];
}
