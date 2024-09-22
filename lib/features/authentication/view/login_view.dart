import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/mixin/login_mixin.dart';
import 'package:voxpollui/features/authentication/view/form_otp.dart';
import 'package:voxpollui/features/authentication/view/form_phone.dart';
import 'package:voxpollui/product/services/firebase/auth_service.dart';

final class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.auth_login.tr()),
      ),
      */
      body: StreamBuilder<AuthStatus>(
        stream: authStream.stream,
        builder: (_, snapshot) {
          final status = snapshot.data;
          if (status == null) return error('loading-snapshot');
          if (status == AuthStatus.none) {
            return FormPhone(
              phoneController: phoneController,
              onPhoneVerify: verifyPhone,
              focusNode: focusNode,
              onayliyorum: onayliyorum,
              emailAlmak: emailAlmak,
            );
          }
          if (status == AuthStatus.onCodeSent) {
            return FormOtp(
              otpController: otpController,
              onOtpVerify: verifyOtp,
            );
          }
          if (status == AuthStatus.onSuccess) return error('success');
          if (status == AuthStatus.onError) return error('error');
          return error('on others');
        },
      ),
    );
  }

  Widget error(String text) {
    return Center(child: Text(text));
  }
}
