import 'package:flutter/material.dart';

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
        ElevatedButton(onPressed: onPhoneVerify, child: const Text('phone')),
      ],
    );
  }
}
