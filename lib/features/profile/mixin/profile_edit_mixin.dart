import 'package:flutter/material.dart';
import 'package:voxpollui/features/profile/view/profile_edit_view.dart';

mixin ProfileEditMixin on State<ProfileEditView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCurrentData();
  }

  void setCurrentData() {
    nameController.text = widget.user.name ?? '';
    surnameController.text = widget.user.surname ?? '';
    usernameController.text = widget.user.userName ?? '';
    emailController.text = widget.user.email ?? '';
  }

  void onSave() {}
}
