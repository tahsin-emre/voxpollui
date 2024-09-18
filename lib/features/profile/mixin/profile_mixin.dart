import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/profile/view/profile_view.dart';
import 'package:voxpollui/product/router/route_tree.dart';

mixin ProfileMixin on State<ProfileView> {
  late final _authCubit = context.read<AuthCubit>();

  Future<void> signOut() async {
    await _authCubit.signOut();
    navToSplash();
  }

  void navToSplash() => const SplashRoute().go(context);
}
