import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/splash/view/splash_view.dart';
import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/router/route_tree.dart';
import 'package:voxpollui/product/services/shared_preferences/shared_service.dart';

mixin SplashMixin on State<SplashView> {
  late final authCubit = context.read<AuthCubit>();

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    final userId = authCubit.handleCurrentUser();
    UserModel? user;
    if (SharedService.isFirstLogin && userId == null) {
      navigateToOnboard();
      return;
    }
    if (userId != null) user = await authCubit.getUser(userId);
    if (user == null) {
      navigateToRegister();
      return;
    }
    navigateToHome();
  }

  void navigateToHome() => const FeedRoute().go(context);
  void navigateToRegister() => const RegisterRoute().go(context);
  void navigateToOnboard() => const OnboardRoute().go(context);
}
