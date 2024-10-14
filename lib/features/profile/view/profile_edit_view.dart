import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/widgets/personal_fields.dart';
import 'package:voxpollui/features/profile/mixin/profile_edit_mixin.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/edit_text_field.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/features/sub_features/common_widgets/image_change_tile.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';

final class ProfileEditView extends StatefulWidget {
  const ProfileEditView({required this.user, super.key});
  final UserModel user;
  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView>
    with ProfileEditMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ImageChangeTile(
                userId: widget.user.id,
                onProfileUrl: changeProfileUrl,
                onBackUrl: changeBackUrl,
                initProfile: profileUrlNotifier.value,
                initBack: backUrlNotifier.value,
              ),
              EditTextField(
                label: LocaleKeys.auth_name,
                controller: nameController,
              ),
              EditTextField(
                label: LocaleKeys.auth_surname,
                controller: surnameController,
              ),
              EditTextField(
                label: LocaleKeys.profile_about,
                controller: descriptionController,
              ),
              EditTextField(
                label: LocaleKeys.auth_email,
                controller: emailController,
              ),
              EditTextField(
                label: LocaleKeys.auth_userName,
                controller: usernameController,
                prefix: '@',
              ),
              DateField(
                changeDate,
                initialDate: dateNotifier.value,
              ),
              ExtendedElevatedButton(
                onPressed: onSave,
                text: LocaleKeys.base_save.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
