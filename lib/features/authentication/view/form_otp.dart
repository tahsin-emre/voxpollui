import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/widgets/next_button.dart';
import 'package:voxpollui/features/authentication/widgets/otp_text_field.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 140),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                LocaleKeys.auth_otpForm_otpCode.tr(),
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 36,
                  fontFamily: FontConstants.gilroyBold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: OtpTextField(
                controller: widget.otpController,
                onOtpVerify: widget.onOtpVerify,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(LocaleKeys.auth_otpForm_resend.tr()),
            ),
            const Spacer(),
            NextButton(onTap: widget.onOtpVerify),
          ],
        ),
      ),
    );
  }
}
