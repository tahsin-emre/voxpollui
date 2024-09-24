import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/widgets/next_button.dart';
import 'package:voxpollui/features/authentication/widgets/phone_text_field.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/image_constants.dart';

class FormPhone extends StatelessWidget {
  const FormPhone({
    required this.phoneController,
    required this.focusNode,
    required this.onPhoneVerify,
    required this.confirmContract,
    required this.confirmContact,
    super.key,
  });
  final TextEditingController phoneController;
  final FocusNode focusNode;
  final VoidCallback onPhoneVerify;
  final bool confirmContract;
  final bool confirmContact;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(ImageConstants.phoneImage),
          ),
          Text(
            LocaleKeys.auth_phoneForm_phoneNumber.tr(),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          PhoneTextField(
            controller: phoneController,
            focusNode: focusNode,
          ),
          const Spacer(),
          Text(LocaleKeys.auth_phoneForm_userAgreement.tr()),
          NextButton(onTap: onPhoneVerify),
        ],
      ),
    );
  }
}
