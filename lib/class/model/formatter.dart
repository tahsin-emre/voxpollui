import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Yeni değer boşsa veya önceki değerden kısa ise (karakter siliniyor)
    if (newValue.text.isEmpty || newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Girilen sayıları al
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Biçimi uygula
    final formattedText = _applyPhoneMask(digitsOnly);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _applyPhoneMask(String digits) {
    final buffer = StringBuffer();
    final length = digits.length;

    for (int i = 0; i < length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 3) buffer.write(') ');
      if (i == 6) buffer.write('-');
      buffer.write(digits[i]);
    }

    return buffer.toString();
  }
}
