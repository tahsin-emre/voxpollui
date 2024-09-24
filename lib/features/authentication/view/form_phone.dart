import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/view/custom_checkbox.dart';
import 'package:voxpollui/features/authentication/view/idarelik.dart';
import 'package:voxpollui/features/authentication/view/kvkk.dart';
import 'package:voxpollui/features/authentication/view/phone_textfield.dart';
import 'package:voxpollui/features/home/view/home_view.dart';
import 'package:voxpollui/product/constants/color_constants.dart';
import 'package:voxpollui/product/constants/font_constants.dart';
import 'package:voxpollui/product/constants/image_constants.dart';
import 'package:voxpollui/product/localization/locale_keys.g.dart';

class FormPhone extends StatelessWidget {
  const FormPhone({
    required this.phoneController,
    required this.focusNode,
    required this.onPhoneVerify,
    required this.onayliyorum,
    required this.emailAlmak,
    super.key,
  });
  final TextEditingController phoneController;
  final FocusNode focusNode;
  final VoidCallback onPhoneVerify;
  final bool onayliyorum;
  final bool emailAlmak;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Center(
              child: Image.asset(
                ImageConstants.phoneImage,
                height: 200,
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
            child: Text(
              '${LocaleKeys.onboard_page2_phone1.tr()}\n${LocaleKeys.onboard_page2_phone2.tr()}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: FontConstants.gilroySemibold,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 30, 0, 0),
            child: SizedBox(
              width: 332,
              height: 48,
              child: PhoneTextField(
                controller: phoneController,
                focusNode: focusNode,
                hintText: '555 123 45 67',
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomCheckbox(
                isChecked: onayliyorum,
                onChanged: (bool value) {
                  /*
                  setState(() {
                    onayliyorum = value;
                  });
                  */
                },
                child: Text.rich(
                  TextSpan(
                    text: LocaleKeys.onboard_page2_kvkk1.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: FontConstants.gilroyBold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Kvkk())));
                      },
                    children: [
                      TextSpan(
                        text: LocaleKeys.onboard_page2_kvkk2.tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: FontConstants.gilroyLight,
                        ),
                      ),
                      TextSpan(
                        text: LocaleKeys.onboard_page2_kvkk3.tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: FontConstants.gilroyBold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const Kvkk())));
                          },
                      ),
                      TextSpan(
                        text: LocaleKeys.onboard_page2_kvkk4.tr(),
                        style: TextStyle(
                          color: const Color(0xFF0C0C0C),
                          fontFamily: FontConstants.gilroyLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomCheckbox(
                isChecked: emailAlmak,
                onChanged: (bool value) {
                  /*
                  setState(() {
                    emailAlmak = value;
                  });
                  */
                },
                child: Text.rich(
                  TextSpan(
                    text: LocaleKeys.onboard_page2_kvkk5.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: FontConstants.gilroyLight,
                    ),
                    children: [
                      TextSpan(
                        text: LocaleKeys.onboard_page2_kvkk6.tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: FontConstants.gilroyBold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const Kvkk())));
                          },
                      ),
                      TextSpan(
                        text: LocaleKeys.onboard_page2_kvkk7.tr(),
                        style: TextStyle(
                          color: const Color(0xFF0C0C0C),
                          fontSize: 13,
                          fontFamily: FontConstants.gilroyLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          /*
          ElevatedButton(
            onPressed: onPhoneVerify,
            child: Text(LocaleKeys.onboard_continue.tr()),
          ),
          */
          const Spacer(),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Kvkk()),
                  );
                },
                child: SizedBox(
                  width: 333,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: LocaleKeys.onboard_page2_ifcontinue1.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: FontConstants.gilroyLight,
                          ),
                        ),
                        TextSpan(
                          text: LocaleKeys.onboard_page2_ifcontinue2.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: FontConstants.gilroyBold,
                          ),
                        ),
                        TextSpan(
                          text: LocaleKeys.onboard_page2_ifcontinue3.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: FontConstants.gilroyLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BoardinUc()));
                },
                /*
                onPhoneVerify,
                if (onayliyorum && emailAlmak) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BoardinUc()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 10,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                'Dikkat',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Rıza Metinleri Kabul Edilmelidir',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[700],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Divider(
                                color: Colors.grey[300],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Tamam',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                */
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 49,
                  margin: const EdgeInsets.all(31),
                  decoration: ShapeDecoration(
                    color: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'İleri',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: FontConstants.gilroyBlack,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
