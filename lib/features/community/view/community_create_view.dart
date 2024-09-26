import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/community/mixin/community_create_mixin.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_input_decoration.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

class CommunityCreateView extends StatefulWidget {
  const CommunityCreateView({super.key});

  @override
  State<CommunityCreateView> createState() => _CommunityCreateViewState();
}

class _CommunityCreateViewState extends State<CommunityCreateView>
    with CommunityCreateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Padding(
        padding: PagePaddings.horL,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.community_createCommunity.tr(),
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: FontConstants.gilroyBold,
                ),
              ),
              _NameField(nameCont, onImage: () {}),
              const SizedBox(height: WidgetSizes.xl),
              const _CategoryField(),
              const SizedBox(height: WidgetSizes.xl),
              _PublicField(
                valueNotifier: isPublic,
                onChanged: (val) => isPublic.value = val,
              ),
              const SizedBox(height: WidgetSizes.xl),
              ExtendedElevatedButton(
                onPressed: onSave,
                text: LocaleKeys.community_createCommunity.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _NameField extends StatelessWidget {
  const _NameField(this.controller, {required this.onImage});
  final TextEditingController controller;
  final VoidCallback onImage;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColor.primary,
      decoration: CustomInputDecoration(
        labelText: LocaleKeys.community_communityName.tr(),
        suffixIcon: IconConstants.imageAdd,
        suffixTap: onImage,
      ),
    );
  }
}

final class _CategoryField extends StatelessWidget {
  const _CategoryField();
  static final _dropDownKey = GlobalKey<DropdownSearchState<String>>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.community_category.tr(),
          style: TextStyle(
            fontSize: 18,
            fontFamily: FontConstants.gilroyBold,
          ),
        ),
        DropdownSearch<String>(
          key: _dropDownKey,
          selectedItem: "Menu",
          items: (filter, infiniteScrollProps) =>
              ["Menu", "Dialog", "Modal", "BottomSheet"],
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'Examples for: ',
              border: OutlineInputBorder(),
            ),
          ),
          popupProps: PopupProps.menu(
              fit: FlexFit.loose, constraints: BoxConstraints()),
        ),
      ],
    );
  }
}

final class _PublicField extends StatelessWidget {
  const _PublicField({required this.valueNotifier, required this.onChanged});
  final ValueListenable<bool> valueNotifier;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (_, value, __) {
        return Row(
          children: [
            Text(
              value
                  ? LocaleKeys.community_public.tr()
                  : LocaleKeys.community_private.tr(),
              style: TextStyle(
                fontSize: 18,
                fontFamily: FontConstants.gilroyBold,
              ),
            ),
            const Spacer(),
            Switch(
              value: value,
              onChanged: onChanged,
              inactiveTrackColor: Colors.white,
              activeColor: AppColor.primary,
              inactiveThumbColor: AppColor.primary,
            ),
          ],
        );
      },
    );
  }
}
