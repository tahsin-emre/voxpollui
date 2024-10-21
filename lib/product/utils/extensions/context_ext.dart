import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showSheet(Widget sheet) {
    showModalBottomSheet<void>(
      context: this,
      builder: (context) => sheet,
    );
  }
}
