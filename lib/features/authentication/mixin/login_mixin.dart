import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/authentication/view/login_view.dart';
import 'package:voxpollui/product/services/firebase/auth_service.dart';

mixin LoginMixin on State<LoginView> {
  late final authCubit = context.read<AuthCubit>();
  late final phoneController = TextEditingController(text: '+905300387436');
  late final otpController = TextEditingController();
  final _authService = AuthService();
  final authStream = StreamController<AuthStatus>();

  @override
  void initState() {
    super.initState();
    authStream.sink.add(AuthStatus.none);
  }

  Future<void> verifyPhone() async {
    await _authService.verifyPhone(
      phoneNumber: '+905300387436',
      authStream: authStream,
    );
  }

  Future<void> verifyOtp() async {
    await _authService.verifyOtp(
      code: otpController.text,
      authStream: authStream,
    );
  }
}
