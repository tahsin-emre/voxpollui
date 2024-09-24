import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';

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
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 5, 15),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Onay Kodu',
                style: TextStyle(
                  color: const Color(0xFF0C0C0C),
                  fontSize: 40,
                  fontFamily: FontConstants.gilroyMedium,
                  height: 0,
                ),
              ),
            ),
          ),
          const Text('otp form'),
          TextField(controller: widget.otpController),
          ElevatedButton(
            onPressed: widget.onOtpVerify,
            child: const Text('otp'),
          ),
        ],
      ),
    );
  }
}
