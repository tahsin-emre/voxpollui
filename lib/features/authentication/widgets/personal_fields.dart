import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

final class DateField extends StatelessWidget {
  const DateField(this.onDateChanged, {super.key});
  final ValueChanged<DateTime?> onDateChanged;
  static final _dateNotifier = ValueNotifier<String?>(null);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(primary: AppColor.primary),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
        );
        if (date == null) return;
        _dateNotifier.value = _formatDate(date);
        onDateChanged(date);
      },
      child: ValueListenableBuilder(
        valueListenable: _dateNotifier,
        builder: (_, text, __) {
          return Container(
            margin: PagePaddings.allS,
            padding: PagePaddings.verS,
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide()),
            ),
            child: Text(
              text ?? LocaleKeys.auth_dateOfBirth.tr(),
              style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontFamily: FontConstants.gilroyMedium,
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

final class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    required this.label,
    required this.controller,
    super.key,
  });
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
