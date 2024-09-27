import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/profile/cubit/profile_cubit.dart';
import 'package:voxpollui/features/profile/view/profile_view.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';

mixin ProfileMixin on State<ProfileView> {
  late final _profileCubit = context.read<ProfileCubit>();
  late final _authCubit = context.read<AuthCubit>();
  late final pageNotifier = ValueNotifier<int>(0);
  bool get isOwnProfile => widget.userId == null;

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    var uid = widget.userId;
    uid ??= _authCubit.state.user?.id;
    if (uid == null) return;
    await _profileCubit.fetchUser(uid);
  }

  Future<void> signOut() async {
    await _authCubit.signOut();
    navToSplash();
  }

  void navToSplash() => const SplashRoute().go(context);
}
