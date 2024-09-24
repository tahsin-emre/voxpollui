import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/authentication/view/login_view.dart';
import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/auth_service.dart';

mixin LoginMixin on State<LoginView> {
  late final authCubit = context.read<AuthCubit>();
  final TextEditingController phoneController = TextEditingController();
  final focusNode = FocusNode();
  final otpController = TextEditingController();
  final _authService = AuthService();
  final authStream = StreamController<AuthStatus>();
  bool confirmContract = false;
  bool confirmContact = false;

  @override
  void initState() {
    super.initState();
    authStream.sink.add(AuthStatus.none);
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    phoneController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> verifyPhone() async {
    await _authService.verifyPhone(
      phoneNumber: phoneController.text,
      authStream: authStream,
    );
  }

  Future<void> verifyOtp() async {
    final uid = await _authService.verifyOtp(
      code: otpController.text,
      authStream: authStream,
    );
    if (uid == null) return;
    final user = await authCubit.getUser(uid);
    if (user == null) {
      navigateToRegister(UserModel(id: uid, phone: phoneController.text));
      return;
    }
    navigateToHome();
    return;
  }

  void navigateToHome() => const FeedRoute().go(context);
  void navigateToRegister(UserModel user) => RegisterRoute(user).go(context);
}
