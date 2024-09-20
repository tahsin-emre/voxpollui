import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/constants/font_constants.dart';
import 'package:voxpollui/product/localization/locale_keys.g.dart';

class OnboardDescription extends StatelessWidget {
  const OnboardDescription({required this.onContinue, super.key});
  final VoidCallback onContinue;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 47,
          top: 500,
          child: Text(
            LocaleKeys.onboard_page1_appinfo1.tr(),
            style: TextStyle(
              color: const Color(0xFF0C0C0C),
              fontSize: 36,
              fontFamily: FontConstants.gilroyLight,
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
        ),
        Positioned(
          left: 47,
          top: 544,
          child: Text(
            LocaleKeys.onboard_page1_appinfo2.tr(),
            style: TextStyle(
              color: const Color(0xFF0C0C0C),
              fontSize: 36,
              fontFamily: FontConstants.gilroyLight,
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
        ),
        Positioned(
          left: 47,
          top: 588,
          child: Text(
            LocaleKeys.onboard_page1_appinfo3.tr(),
            style: TextStyle(
              color: const Color(0xFF2355FF),
              fontSize: 36,
              fontFamily: FontConstants.gilroyBlack,
              height: 0,
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: 620,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: onContinue,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width / 2 - 50,
                height: 49,
                margin: const EdgeInsets.all(31),
                decoration: ShapeDecoration(
                  color: const Color(0xFF2355FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.onboard_page1_start.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: FontConstants.gilroySemibold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
