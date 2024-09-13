import 'package:flutter/material.dart';

class FormOtp extends StatefulWidget {
  const FormOtp({
    required this.otpController,
    required this.onOtpVerify,
    super.key,
  });
  final TextEditingController otpController;
  final VoidCallback onOtpVerify;

  @override
  State<FormOtp> createState() => _FormOtpState();
}

class _FormOtpState extends State<FormOtp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('otp form'),
        TextField(controller: widget.otpController),
        ElevatedButton(
          onPressed: widget.onOtpVerify,
          child: const Text('otp'),
        ),
      ],
    );
  }
}
