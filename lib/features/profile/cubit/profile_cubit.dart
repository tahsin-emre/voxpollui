import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/profile/cubit/profile_state.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/services/firebase/poll_service.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';

final class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final _userService = UserService();
  final _pollService = PollService();

  Future<void> fetchUser(String userId) async {
    emit(state.copyWith(isLoading: true));
    final user = await _userService.getUser(userId);
    emit(
      state.copyWith(
        user: user,
        isLoading: false,
      ),
    );
  }

  void followUser() {
    final user = state.user;
    if (user == null) return;
    emit(
      state.copyWith(
        user: user.copyWith(followersCount: user.followersCount + 1),
        isLoading: false,
      ),
    );
  }

  void unfollowUser() {
    final user = state.user;
    if (user == null) return;
    emit(
      state.copyWith(
        user: user.copyWith(followersCount: user.followersCount - 1),
        isLoading: false,
      ),
    );
  }

  Future<void> fetchUserPolls(String userId) async {
    final createdPolls = await _pollService.getPollsByUser(userId);
    final participatedPolls = await _pollService.getPollsParticipated(userId);
    emit(
      state.copyWith(
        createdPolls: createdPolls,
        participatedPolls: participatedPolls,
      ),
    );
  }

  void updateUser(UserModel user) {
    emit(state.copyWith(user: user));
  }
}
