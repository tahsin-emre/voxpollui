import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_state.dart';
import 'package:voxpollui/features/poll/mixin/poll_create_mixin.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_input_decoration.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/poll/community_category_model.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

class PollCreateView extends StatefulWidget {
  const PollCreateView({super.key});

  @override
  State<PollCreateView> createState() => _PollCreateViewState();
}

class _PollCreateViewState extends State<PollCreateView> with PollCreateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: BlocBuilder<PollCubit, PollState>(
        builder: (_, state) {
          final categories = state.categoryList ?? [];
          return Skeletonizer(
            enabled: state.isLoading,
            child: Padding(
              padding: PagePaddings.horL,
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.poll_createPoll.tr(),
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: FontConstants.gilroyBold,
                        ),
                      ),
                      const SizedBox(height: WidgetSizes.xl),
                      _NameField(
                        titleCont,
                        imageUrlNotifier: imageUrlNotifier,
                        onImage: pickImage,
                      ),
                      const SizedBox(height: WidgetSizes.xl),
                      _CategoryField(
                        categories,
                        onChanged: (value) => categoryIdNotifier.value = value,
                      ),
                      const SizedBox(height: WidgetSizes.xl),
                      _PublicField(
                        valueNotifier: isPublicNotifier,
                        onChanged: (value) => isPublicNotifier.value = value,
                      ),
                      ExtendedElevatedButton(
                        onPressed: onSave,
                        text: LocaleKeys.poll_publish,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final class _NameField extends StatelessWidget {
  const _NameField(
    this.controller, {
    required this.imageUrlNotifier,
    required this.onImage,
  });
  final TextEditingController controller;
  final ValueListenable<String?> imageUrlNotifier;
  final VoidCallback onImage;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: imageUrlNotifier,
      builder: (_, url, __) {
        return Column(
          children: [
            if (url != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
            TextField(
              controller: controller,
              cursorColor: AppColor.primary,
              autofocus: true,
              decoration: CustomInputDecoration(
                labelText: LocaleKeys.poll_pollTitle.tr(),
                suffixIcon: IconConstants.imageAdd,
                suffixTap: onImage,
              ),
            ),
          ],
        );
      },
    );
  }
}

final class _CategoryField extends StatelessWidget {
  const _CategoryField(this.categories, {required this.onChanged});
  final List<PollCategoryModel> categories;
  final ValueChanged<String> onChanged;
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
          child: CustomDropdown<PollCategoryModel>.search(
            onChanged: (value) {
              if (value == null) return;
              onChanged(value.id);
            },
            items: categories,
            listItemPadding: EdgeInsets.zero,
            itemsListPadding: EdgeInsets.zero,
            expandedHeaderPadding: EdgeInsets.zero,
            closedHeaderPadding: EdgeInsets.zero,
            hintText: LocaleKeys.community_categoryHint.tr(),
            searchHintText: LocaleKeys.base_search.tr(),
            noResultFoundText: LocaleKeys.community_categoryNotFound.tr(),
            headerBuilder: (_, item, __) => ListTile(
              title: Text(item.name ?? ''),
            ),
            listItemBuilder: (_, item, __, ___) {
              return ListTile(
                title: Text(item.name ?? ''),
              );
            },
          ),
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
                  ? LocaleKeys.poll_public.tr()
                  : LocaleKeys.poll_private.tr(),
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
