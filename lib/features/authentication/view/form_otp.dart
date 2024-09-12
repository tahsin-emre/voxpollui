import 'package:flutter/material.dart';

class FormOtp extends StatefulWidget {
  const FormOtp({required this.otpController, super.key});
  final TextEditingController otpController;

  @override
  State<FormOtp> createState() => _FormOtpState();
}

class _FormOtpState extends State<FormOtp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
