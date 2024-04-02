import 'package:flutter/material.dart';

class NationalButton {
  Widget nationalButton(String text) {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2355FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), // Border radius
        ),
      ),
      child: const Text(
        'Ana Sayfa', style: TextStyle(color: Colors.white),
        // Background color
      ),
    );
  }
}
