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

  Future<T?> showSheet<T>(Widget sheet) {
    return showModalBottomSheet<T?>(
      barrierColor: Colors.white38,
      context: this,
      builder: (context) => sheet,
    );
  }
}
