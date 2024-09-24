import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';

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
            LocaleKeys.onboard_appinfo1.tr(),
            style: TextStyle(
              color: AppColor.black,
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
            LocaleKeys.onboard_appinfo2.tr(),
            style: TextStyle(
              color: AppColor.black,
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
            LocaleKeys.onboard_appinfo3.tr(),
            style: TextStyle(
              color: AppColor.primary,
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
                  color: AppColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.onboard_start.tr(),
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
