import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/view/register_view.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';
import 'package:voxpollui/product/utils/extensions/context_ext.dart';

mixin RegisterMixin on State<RegisterView> {
  final indexNotifier = ValueNotifier<int>(0);
  final _userService = UserService();
  late UserModel user = widget.user;
  final categoryList = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    final response = await _userService.getCategories();
    if (response.isEmpty) return;
    categoryList.addAll(response);
  }

  void onNext(UserModel newUser) {
    user = newUser;
    indexNotifier.value = 1;
  }

  Future<void> register(UserModel newUser) async {
    final lastUser = newUser.copyWith(
      isPublic: true,
      createdAt: DateTime.now(),
    );
    final result = await _userService.createUser(lastUser);
    if (!result) {
      showSnackBar('Failed to register');
      return;
    }
    indexNotifier.value = 2;
  }

  void showSnackBar(String text) => context.showSnackBar(text);
}
