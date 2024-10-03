import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/province/province_model.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

class FormPersonal extends StatefulWidget {
  const FormPersonal({
    required this.onNext,
    required this.initialUser,
    required this.formKey,
    super.key,
  });
  final ValueChanged<UserModel> onNext;
  final UserModel initialUser;
  final GlobalKey<FormState> formKey;

  @override
  State<FormPersonal> createState() => _FormPersonalState();
}

class _FormPersonalState extends State<FormPersonal> {
  final isLoadingNotifier = ValueNotifier<bool>(false);
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? dateOfBirth;
  ProvinceModel? selectedProvince;
  DistrictModel? selectedDistrict;
  List<ProvinceModel> provinces = [];
  List<DistrictModel> districts = [];

  @override
  void initState() {
    super.initState();
    getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.allS,
      child: Form(
        key: widget.formKey,
        child: ValueListenableBuilder(
          valueListenable: isLoadingNotifier,
          builder: (_, isLoading, __) {
            if (isLoading) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: WidgetSizes.x4L),
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
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                  },
                  child: _RegisterTextField(
                    label: LocaleKeys.auth_dateOfBirth,
                    controller: dateController,
                  ),
                ),
                CustomDropdown<ProvinceModel>.search(
                  onChanged: (value) {
                    if (value == null) return;
                    selectedProvince = value;
                    selectedDistrict = null;
                    setState(() => districts = value.districts);
                  },
                  items: provinces,
                  initialItem: selectedProvince,
                  listItemPadding: EdgeInsets.zero,
                  itemsListPadding: EdgeInsets.zero,
                  expandedHeaderPadding: EdgeInsets.zero,
                  closedHeaderPadding: EdgeInsets.zero,
                  hintText: LocaleKeys.auth_province.tr(),
                  searchHintText: LocaleKeys.base_search.tr(),
                  noResultFoundText:
                      LocaleKeys.auth_personalForm_provinceNotFound.tr(),
                  headerBuilder: (_, item, __) => ListTile(
                    title: Text(item.name),
                  ),
                  listItemBuilder: (_, item, __, ___) {
                    return ListTile(title: Text(item.name));
                  },
                ),
                CustomDropdown<DistrictModel>.search(
                  onChanged: (value) {
                    if (value == null) return;
                    selectedDistrict = value;
                  },
                  items: districts,
                  initialItem: selectedDistrict,
                  listItemPadding: EdgeInsets.zero,
                  itemsListPadding: EdgeInsets.zero,
                  expandedHeaderPadding: EdgeInsets.zero,
                  closedHeaderPadding: EdgeInsets.zero,
                  hintText: LocaleKeys.auth_district.tr(),
                  searchHintText: LocaleKeys.base_search.tr(),
                  noResultFoundText:
                      LocaleKeys.auth_personalForm_districtNotFound.tr(),
                  headerBuilder: (_, item, __) => ListTile(
                    title: Text(item.districtName),
                  ),
                  listItemBuilder: (_, item, __, ___) {
                    return ListTile(title: Text(item.districtName));
                  },
                ),
                ExtendedElevatedButton(
                  onPressed: () {
                    final user = widget.initialUser.copyWith(
                      name: nameController.text,
                      surname: surnameController.text,
                      userName: userNameController.text,
                      email: emailController.text,
                      province: selectedProvince?.value,
                      district: selectedDistrict?.value,
                      gender: 0,
                    );
                    widget.onNext(user);
                  },
                  text: LocaleKeys.base_next.tr(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> getProvinces() async {
    isLoadingNotifier.value = true;
    final jsonString = await rootBundle.loadString('assets/data/il_ilce.json');
    final jsonResponse = json.decode(jsonString) as List;
    provinces = jsonResponse
        .map<ProvinceModel>(
          (e) => ProvinceModel.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    isLoadingNotifier.value = false;
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
          labelText: label.tr(),
        ),
      ),
    );
  }
}
