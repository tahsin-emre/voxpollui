part of '../view/poll_create_view.dart';

final class _OptionsField extends StatefulWidget {
  const _OptionsField({required this.optionsNotifier, required this.onChanged});
  final ValueNotifier<List<OptionModel>> optionsNotifier;
  final ValueChanged<List<OptionModel>> onChanged;

  @override
  State<_OptionsField> createState() => _OptionsFieldState();
}

class _OptionsFieldState extends State<_OptionsField> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.optionsNotifier,
      builder: (_, options, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.poll_options.tr(),
              style: TextStyle(
                fontSize: 18,
                fontFamily: FontConstants.gilroyBold,
              ),
            ),
            for (var i = 0; i < options.length; i++)
              _PollCreateOptionField(
                onChanged: (text) {
                  options[i] = options[i].copyWith(optionText: text);
                  widget.onChanged(options);
                  setState(() {});
                },
                id: int.tryParse(options[i].id) ?? 0,
              ),
            ListTile(
              onTap: () {
                options.add(
                  OptionModel(
                    id: options.length.toString(),
                    optionText: '',
                    voteCount: 0,
                  ),
                );
                widget.onChanged(options);
                setState(() {});
              },
              title: Text(
                LocaleKeys.poll_addOption.tr(),
                style: TextStyle(fontFamily: FontConstants.gilroySemibold),
              ),
              leading: CircleAvatar(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                child: IconConstants.add.toIcon,
              ),
              contentPadding: PagePaddings.horS,
            ),
          ],
        );
      },
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
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            TextField(
              controller: controller,
              cursorColor: AppColor.primary,
              autofocus: true,
              style: TextStyle(
                fontFamily: FontConstants.gilroySemibold,
                fontSize: 18,
              ),
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

final class _TimeField extends StatefulWidget {
  const _TimeField({
    required this.dayCont,
    required this.hourCont,
    required this.minuteCont,
  });
  final TextEditingController dayCont;
  final TextEditingController hourCont;
  final TextEditingController minuteCont;

  @override
  State<_TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<_TimeField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.poll_pollTime.tr(),
          style: TextStyle(
            fontSize: 18,
            fontFamily: FontConstants.gilroyBold,
          ),
        ),
        const SizedBox(height: WidgetSizes.l),
        Row(
          children: [
            _TimeTextField(
              controller: widget.dayCont,
              label: LocaleKeys.poll_day.tr(),
            ),
            _TimeTextField(
              controller: widget.hourCont,
              label: LocaleKeys.poll_hour.tr(),
            ),
            _TimeTextField(
              controller: widget.minuteCont,
              label: LocaleKeys.poll_minute.tr(),
            ),
          ],
        ),
      ],
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

final class _PollCreateOptionField extends StatelessWidget {
  const _PollCreateOptionField({required this.onChanged, required this.id});
  final ValueChanged<String> onChanged;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.verS,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: FontConstants.gilroySemibold,
          fontSize: 16,
        ),
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          contentPadding: PagePaddings.horS,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.secondary),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary),
          ),
          prefix: Padding(
            padding: PagePaddings.horS,
            child: Text(
              '${id + 1}.',
              style: TextStyle(
                color: AppColor.primary,
                fontFamily: FontConstants.gilroyBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _TimeTextField extends StatelessWidget {
  const _TimeTextField({required this.controller, required this.label});
  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: PagePaddings.horS,
        child: TextField(
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          decoration: InputDecoration(
            contentPadding: PagePaddings.horS,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            label: Text(
              label,
              style: TextStyle(
                fontFamily: FontConstants.gilroyLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
