import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';

final class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    required super.labelText,
    VoidCallback? suffixTap,
    IconData? suffixIcon,
  }) : super(
          border: const UnderlineInputBorder(),
          labelStyle: const TextStyle(color: Colors.black),
          focusColor: AppColor.primary,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary),
          ),
          enabledBorder: const UnderlineInputBorder(),
          suffix: suffixTap != null
              ? InkWell(
                  onTap: suffixTap,
                  child: (suffixIcon ?? IconConstants.more).toSmallIcon(),
                )
              : null,
        );
}
