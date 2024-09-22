import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voxpollui/product/constants/font_constants.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;

  // Custom formatter for phone number
  static final _phoneNumberFormatter = PhoneNumberFormatter();

  const PhoneTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText = '555 123 45 67',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 332,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(13),
            FilteringTextInputFormatter.digitsOnly,
            _phoneNumberFormatter,
          ],
          keyboardType: TextInputType.phone,
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
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
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1.0),
            ),
            border: InputBorder.none,
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
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final formattedText = _formatAsPhoneNumber(digitsOnly);
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatAsPhoneNumber(String digits) {
    if (digits.length <= 3) {
      return digits;
    } else if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    } else if (digits.length <= 8) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    } else if (digits.length <= 10) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 8)} ${digits.substring(8)}';
    } else {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 8)} ${digits.substring(8, 10)}';
    }
  }
}
