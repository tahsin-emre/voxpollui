import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';

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
      defaultPinTheme: PinTheme(
        width: 56,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(),
        ),
        textStyle:
            TextStyle(fontFamily: FontConstants.gilroyBold, fontSize: 24),
      ),
      controller: controller,
      onCompleted: (value) => onOtpVerify(),
    );
  }
}
