import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

final class CategorySelector extends StatelessWidget {
  const CategorySelector(
    this.categories, {
    required this.onChanged,
    this.initialId,
    super.key,
  });
  final List<CategoryModel> categories;
  final ValueChanged<String> onChanged;
  final String? initialId;
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
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: PagePaddings.horS,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomDropdown<CategoryModel>.search(
            onChanged: (value) {
              if (value == null) return;
              onChanged(value.id);
            },
            initialItem: categories.firstWhereOrNull((e) => e.id == initialId),
            items: categories,
            listItemPadding: EdgeInsets.zero,
            itemsListPadding: EdgeInsets.zero,
            expandedHeaderPadding: EdgeInsets.zero,
            closedHeaderPadding: EdgeInsets.zero,
            hintText: LocaleKeys.community_categoryHint.tr(),
            searchHintText: LocaleKeys.base_search.tr(),
            noResultFoundText: LocaleKeys.community_categoryNotFound.tr(),
            headerBuilder: (_, item, __) => ListTile(
              title: Text(item.name.tr()),
            ),
            listItemBuilder: (_, item, __, ___) {
              return ListTile(
                title: Text(item.name.tr()),
              );
            },
          ),
        ),
      ],
    );
  }
}
