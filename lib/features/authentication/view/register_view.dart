import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/mixin/register_mixin.dart';
import 'package:voxpollui/features/authentication/view/form_interests.dart';
import 'package:voxpollui/features/authentication/view/form_personal.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';

final class RegisterView extends StatefulWidget {
  const RegisterView({required this.user, super.key});
  final UserModel user;
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexNotifier,
          builder: (_, index, __) {
            if (index == 0) {
              return FormPersonal(
                initialUser: user,
                onNext: onNext,
              );
            }
            if (index == 1) {
              return FormInterests(
                initialUser: user,
                onNext: register,
                categories: categoryList,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
