import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({required this.onTap, super.key});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.all(30),
        decoration: ShapeDecoration(
          color: AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.base_next.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: FontConstants.gilroyBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
