import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/community/mixin/community_edit_mixin.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/edit_text_field.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/features/sub_features/common_widgets/image_change_tile.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';

class CommunityEditView extends StatefulWidget {
  const CommunityEditView({required this.community, super.key});
  final CommunityModel community;
  @override
  State<CommunityEditView> createState() => _CommunityEditViewState();
}

class _CommunityEditViewState extends State<CommunityEditView>
    with CommunityEditMixin {
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
                userId: widget.community.id,
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
                label: LocaleKeys.profile_about,
                controller: descriptionController,
              ),
              EditTextField(
                label: LocaleKeys.auth_userName,
                controller: usernameController,
                prefix: '@',
              ),
              // Padding(
              //   padding: PagePaddings.allS,
              //   child: CategorySelector(
              //     categories,
              //     initialId: categoryIdNotifier.value,
              //     onChanged: changeCategory,
              //   ),
              // ),
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
