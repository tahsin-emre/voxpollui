import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/splash/view/splash_view.dart';
import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/router/route_tree.dart';

mixin SplashMixin on State<SplashView> {
  late final authCubit = context.read<AuthCubit>();

  Future<void> checkUser() async {
    final userId = authCubit.handleCurrentUserId();
    if (userId == null) {
      navigateToOnboard();
      return;
    }
    final user = await authCubit.getUser(userId);
    if (user == null) {
      final phone = authCubit.handleCurrentUserPhone();
      if (phone == null) return;
      navigateToRegister(UserModel(id: userId, phone: phone));
      return;
    } else {
      navigateToHome();
    }
  }

  void navigateToHome() => const FeedRoute().go(context);
  void navigateToRegister(UserModel user) => RegisterRoute(user).go(context);
  void navigateToOnboard() => const OnboardRoute().go(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUser());
  }

  @override
  void dispose() {
    authCubit.close();
    super.dispose();
  }
}
