import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;

  // Custom formatter for phone number
  static final _phoneNumberFormatter = PhoneNumberFormatter();

  PhoneTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText = '555 123 45 67',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(
                13), // Max length adjusted for formatted number
            FilteringTextInputFormatter.digitsOnly, // Only digits allowed
            _phoneNumberFormatter, // Custom phone number formatter
          ],
          keyboardType: TextInputType.phone,
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            prefix: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '+90 ',
                    style: TextStyle(
                      fontFamily: "Gilroy-medium",
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1.0), // Alt çizgi rengi ve kalınlığı
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.0), // Odaklanıldığında alt çizgi rengi ve kalınlığı
            ),
            border: InputBorder.none,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w400,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'Gilroy',
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
    final digitsOnly =
        newValue.text.replaceAll(RegExp(r'[^\d]'), ''); // Only digits
    final formattedText = _formatAsPhoneNumber(digitsOnly);
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
          offset: formattedText.length), // Cursor at the end
    );
  }

  String _formatAsPhoneNumber(String digits) {
    // Creating phone number format
    if (digits.length <= 3) {
      return digits;
    } else if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    } else if (digits.length <= 8) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    } else {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 8)} ${digits.substring(8, 10)}';
    }
  }
}
