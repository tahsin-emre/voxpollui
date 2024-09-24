import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    required this.controller,
    required this.onOtpVerify,
    super.key,
  });
  final TextEditingController controller;
  final VoidCallback onOtpVerify;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      autofocus: true,
      controller: controller,
      onCompleted: (value) => onOtpVerify(),
    );
  }
}
