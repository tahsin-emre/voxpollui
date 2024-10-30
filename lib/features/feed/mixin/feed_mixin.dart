import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/feed/view/feed_view.dart';
import 'package:voxpollui/features/home/view/home_inherited.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';

mixin FeedMixin on State<FeedView> {
  late final _pollCubit = context.read<PollCubit>();
  late final _authCubit = context.read<AuthCubit>();
  late final _homeState = HomeInherited.of(context).state;
  late final user = _homeState.user;
  final isLoadingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    getFeed();
  }

  Future<void> getFeed() async {
    final user = _authCubit.state.user;
    if (user == null) return;
    final followIds = await _authCubit.getFollowIds();
    await _pollCubit.getFeedPolls(followIds);
  }

  void openDrawer() {
    _homeState.scaffoldKey.currentState?.openEndDrawer();
  }
}
