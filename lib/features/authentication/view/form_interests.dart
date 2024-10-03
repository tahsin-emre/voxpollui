import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

class FormInterests extends StatefulWidget {
  const FormInterests({
    required this.initialUser,
    required this.onNext,
    required this.categories,
    super.key,
  });
  final UserModel initialUser;
  final ValueChanged<UserModel> onNext;
  final List<CategoryModel> categories;
  @override
  State<FormInterests> createState() => _FormInterestsState();
}

class _FormInterestsState extends State<FormInterests> {
  final List<CategoryModel> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.allS,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: WidgetSizes.x3L),
          Text(
            LocaleKeys.auth_personalForm_interests.tr(),
            style: TextStyle(
              fontSize: 40,
              fontFamily: FontConstants.gilroyBold,
            ),
          ),
          Text(LocaleKeys.auth_personalForm_interestsHint.tr()),
          const SizedBox(height: WidgetSizes.xl),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 3.8,
              ),
              itemCount: widget.categories.length,
              itemBuilder: (_, index) {
                final category = widget.categories[index];
                final isSelected = selectedCategories.contains(category);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedCategories.remove(category);
                    } else {
                      if (selectedCategories.length == 10) return;
                      selectedCategories.add(category);
                    }
                    setState(() {});
                  },
                  child: _CategoryBox(
                    category: category,
                    isSelected: isSelected,
                  ),
                );
              },
            ),
          ),
          ExtendedElevatedButton(
            onPressed: () {
              final newUser = widget.initialUser.copyWith(
                interests: selectedCategories.map((e) => e.id).toList(),
              );
              widget.onNext(newUser);
            },
            text: LocaleKeys.base_next.tr(),
          ),
        ],
      ),
    );
  }
}

class _CategoryBox extends StatelessWidget {
  const _CategoryBox({
    required this.category,
    required this.isSelected,
  });
  final CategoryModel category;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColor.primary : AppColor.white,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.name.tr(),
        style: TextStyle(
          color: isSelected ? AppColor.white : AppColor.black,
          fontFamily: FontConstants.gilroyMedium,
        ),
      ),
    );
  }
}
