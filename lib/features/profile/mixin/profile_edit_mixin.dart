import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/profile/cubit/profile_cubit.dart';
import 'package:voxpollui/features/profile/view/profile_edit_view.dart';

mixin ProfileEditMixin on State<ProfileEditView> {
  final profileUrlNotifier = ValueNotifier<String?>(null);
  final backUrlNotifier = ValueNotifier<String?>(null);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCurrentData();
  }

  void changeProfileUrl(String? url) {
    profileUrlNotifier.value = url;
    setState(() {});
  }

  void changeBackUrl(String? url) {
    backUrlNotifier.value = url;
    setState(() {});
  }

  void setCurrentData() {
    profileUrlNotifier.value = widget.user.imageUrl;
    backUrlNotifier.value = widget.user.backgroundUrl;
    nameController.text = widget.user.name ?? '';
    surnameController.text = widget.user.surname ?? '';
    usernameController.text = widget.user.userName ?? '';
    emailController.text = widget.user.email ?? '';
    descriptionController.text = widget.user.description ?? '';
  }

  void onSave() {
    final user = widget.user.copyWith(
      name: nameController.text,
      surname: surnameController.text,
      userName: usernameController.text,
      email: emailController.text,
      imageUrl: profileUrlNotifier.value,
      backgroundUrl: backUrlNotifier.value,
      description: descriptionController.text,
    );
    context.read<AuthCubit>().updateUser(user);
    context.read<ProfileCubit>().updateUser(user);
    context.pop();
  }
}
