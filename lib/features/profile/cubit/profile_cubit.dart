import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/profile/cubit/profile_state.dart';
import 'package:voxpollui/product/services/firebase/poll_service.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';

final class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final _userService = UserService();
  final _pollService = PollService();

  Future<void> fetchUser(String userId) async {
    emit(state.copyWith(isLoading: true));
    final user = await _userService.getUser(userId);
    final createdPolls = await _pollService.getPollsByUser(userId);
    final participatedPolls = await _pollService.getPollsParticipated(userId);
    print(participatedPolls.length);
    emit(
      state.copyWith(
        user: user,
        createdPolls: createdPolls,
        participatedPolls: participatedPolls,
        isLoading: false,
      ),
    );
  }
}
