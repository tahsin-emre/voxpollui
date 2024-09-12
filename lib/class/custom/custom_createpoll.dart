import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';

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
        labelStyle: TextStyle(
          color: AppColor.nationalColor,
          fontFamily: GetFont.GILROY_MEDIUM,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(35, 85, 255, 0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.nationalColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
      ),
      cursorColor: AppColor.nationalColor,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    );
  }
}
