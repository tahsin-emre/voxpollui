import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.blue, // Set label color to blue
          fontWeight: FontWeight.bold, // Make label bold
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue, // Border color is blue
            width: 1.5, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue, // Border color when focused
            width: 2.0, // Slightly thicker when focused
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0, // Adjust padding for better appearance
        ),
      ),
      cursorColor: Colors.blue, // Cursor color to blue
      style: const TextStyle(
        color: Colors.black, // Text color
        fontSize: 16.0, // Font size of the input text
      ),
    );
  }
}
