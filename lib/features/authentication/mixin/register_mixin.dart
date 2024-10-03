import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/view/register_view.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';
import 'package:voxpollui/product/utils/extensions/context_ext.dart';

mixin RegisterMixin on State<RegisterView> {
  final indexNotifier = ValueNotifier<int>(0);
  final formKey = GlobalKey<FormState>();
  final _userService = UserService();
  late UserModel user = widget.user;

  void onNext(UserModel newUser) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    user = newUser;
    indexNotifier.value = 1;
  }

  Future<void> register() async {
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
