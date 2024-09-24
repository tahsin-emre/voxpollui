// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/services.dart';

final class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
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
