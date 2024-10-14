import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_input_decoration.dart';

///Has own localization on label
final class EditTextField extends StatelessWidget {
  const EditTextField({
    required this.label,
    required this.controller,
    this.prefix,
    super.key,
  });
  final String label;
  final TextEditingController controller;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        decoration: CustomInputDecoration(
          labelText: label.tr(),
          prefix: prefix,
        ),
      ),
    );
  }
}
