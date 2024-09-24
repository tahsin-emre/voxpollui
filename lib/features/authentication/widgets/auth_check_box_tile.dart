import 'package:flutter/material.dart';

class AuthCheckBoxTile extends StatelessWidget {
  const AuthCheckBoxTile({
    required this.text,
    required this.onChanged,
    required this.initValue,
    super.key,
  });
  final String text;
  final bool initValue;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      value: initValue,
      onChanged: onChanged,
      title: Text(text),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
