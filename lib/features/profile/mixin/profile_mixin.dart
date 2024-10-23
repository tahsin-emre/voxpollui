import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/profile/view/profile_view.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/poll_service.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';

mixin ProfileMixin on State<ProfileView> {
  final _userService = UserService();
  final _pollService = PollService();
  late final _authCubit = context.read<AuthCubit>();
  late final pageNotifier = ValueNotifier<int>(0);
  final isLoadingNotifier = ValueNotifier<bool>(false);
  UserModel? user;
  final List<PollModel> createdPolls = [];
  final List<PollModel> participatedPolls = [];

  bool get isOwnProfile => widget.userId == _authCubit.state.user?.id;

  @override
  void initState() {
    super.initState();
    fetchAllData();
    getPolls();
  }

  void followUser() {
    user = user?.copyWith(followersCount: user!.followersCount + 1);
    setState(() {});
  }

  void unfollowUser() {
    user = user?.copyWith(followersCount: user!.followersCount - 1);
    setState(() {});
  }

  Future<void> fetchAllData() async {
    isLoadingNotifier.value = true;
    user = await _userService.getUser(widget.userId);
    isLoadingNotifier.value = false;
  }

  Future<void> getPolls() async {
    createdPolls.addAll(await _pollService.getPollsByUser(widget.userId));
    participatedPolls
        .addAll(await _pollService.getPollsParticipated(widget.userId));
    setState(() {});
  }

  void navToSplash() => const SplashRoute().go(context);
}
