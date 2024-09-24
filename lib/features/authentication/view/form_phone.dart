import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/authentication/view/custom_checkbox.dart';
import 'package:voxpollui/features/authentication/view/idarelik.dart';
import 'package:voxpollui/features/authentication/view/kvkk.dart';
import 'package:voxpollui/features/authentication/widgets/phone_text_field.dart';
import 'package:voxpollui/features/sub_features/documents/data/aydinlatma_metni.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/router/route_tree.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/image_constants.dart';

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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
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
              '${LocaleKeys.onboard_page2_phone1.tr()}${LocaleKeys.onboard_page2_phone2.tr()}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: FontConstants.gilroySemibold,
                height: 0,
              ),
            ),
          ),
          PhoneTextField(
            controller: phoneController,
            focusNode: focusNode,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomCheckbox(
                isChecked: onayliyorum,
                onChanged: (bool value) {},
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
                        const DocumentReaderRoute(
                          title: AydinlatmaMetni.title,
                          content: AydinlatmaMetni.content,
                        ).go(context);
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
