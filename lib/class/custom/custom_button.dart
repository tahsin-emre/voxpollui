import 'package:flutter/material.dart';

class NationalButton {
  static Widget nationalButton(
      {
        required String text,
        required Function() onPressed,
      }
    ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2355FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), // Border radius
        ),
      ),
      child: Text(
        text, style: const TextStyle(color: Colors.white),
        // Background color
      ),
    );
  }
}
