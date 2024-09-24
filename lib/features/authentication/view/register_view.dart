import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/mixin/register_mixin.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/models/user_model.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.auth_register.tr(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            _RegisterTextField(
              label: LocaleKeys.auth_name.tr(),
              controller: nameController,
            ),
            _RegisterTextField(
              label: LocaleKeys.auth_surname.tr(),
              controller: surnameController,
            ),
            _RegisterTextField(
              label: LocaleKeys.auth_userName.tr(),
              controller: userNameController,
            ),
            _RegisterTextField(
              label: LocaleKeys.auth_email.tr(),
              controller: emailController,
            ),
            ElevatedButton(
              onPressed: register,
              child: Text(
                LocaleKeys.auth_register.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterTextField extends StatelessWidget {
  const _RegisterTextField({required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
