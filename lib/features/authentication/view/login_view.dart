import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/mixin/login_mixin.dart';
import 'package:voxpollui/product/localization/locale_keys.g.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.auth_login.tr()),
      ),
      body: Center(
        child: Text(
          LocaleKeys.auth_login.tr(),
        ),
      ),
    );
  }
}
