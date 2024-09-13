import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/localization/locale_keys.g.dart';

class FormPhone extends StatelessWidget {
  const FormPhone({
    required this.phoneController,
    required this.onPhoneVerify,
    super.key,
  });
  final TextEditingController phoneController;
  final VoidCallback onPhoneVerify;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('phone form'),
        TextField(controller: phoneController),
        ElevatedButton(
          onPressed: onPhoneVerify,
          child: Text(LocaleKeys.onboard_continue.tr()),
        ),
      ],
    );
  }
}
