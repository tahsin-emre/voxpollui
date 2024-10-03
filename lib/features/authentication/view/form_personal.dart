import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

class FormPersonal extends StatelessWidget {
  const FormPersonal({
    required this.nameController,
    required this.surnameController,
    required this.userNameController,
    required this.emailController,
    super.key,
  });
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.allS,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.auth_personalForm_personalInfo.tr(),
            style: TextStyle(
              fontSize: 40,
              fontFamily: FontConstants.gilroyBold,
            ),
          ),
          Text(LocaleKeys.auth_personalForm_subtitle.tr()),
          Text(LocaleKeys.auth_personalForm_subtitle2.tr()),
          _RegisterTextField(
            label: LocaleKeys.auth_name,
            controller: nameController,
          ),
          _RegisterTextField(
            label: LocaleKeys.auth_surname,
            controller: surnameController,
          ),
          _RegisterTextField(
            label: LocaleKeys.auth_userName,
            controller: userNameController,
          ),
          _RegisterTextField(
            label: LocaleKeys.auth_email,
            controller: emailController,
          ),
        ],
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
