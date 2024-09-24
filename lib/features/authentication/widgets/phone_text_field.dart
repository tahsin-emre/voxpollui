import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/formatters/phone_formatter.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    required this.controller,
    this.focusNode,
    super.key,
  });
  final TextEditingController controller;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    final phoneNumberFormatter = PhoneNumberFormatter();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: TextField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(13),
          FilteringTextInputFormatter.digitsOnly,
          phoneNumberFormatter,
        ],
        keyboardType: TextInputType.phone,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefix: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '+90 ',
                  style: TextStyle(
                    fontFamily: FontConstants.gilroySemibold,
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(),
          border: InputBorder.none,
          hintText: '5XX XXX XX XX',
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: FontConstants.gilroyLight,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontFamily: FontConstants.gilroyLight,
          fontWeight: FontWeight.w400,
        ),
        cursorColor: Colors.blue,
      ),
    );
  }
}
