import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/view/register_view.dart';
import 'package:voxpollui/product/extensions/context_ext.dart';
import 'package:voxpollui/product/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';

mixin RegisterMixin on State<RegisterView> {
  final _userService = UserService();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> register() async {
    final user = widget.user.copyWith(
      name: nameController.text,
      surname: surnameController.text,
      userName: userNameController.text,
      email: emailController.text,
    );

    final result = await _userService.createUser(user);
    if (!result) {
      showSnackBar('Failed to register');
      return;
    }
    navigateToHome();
  }

  void navigateToHome() => const FeedRoute().go(context);
  void showSnackBar(String text) => context.showSnackBar(text);
}
