import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';

final class CustomAppBar extends AppBar {
  CustomAppBar(BuildContext context, {String? title, super.key})
      : super(
          backgroundColor: AppColor.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: FontConstants.gilroyBold,
              ),
            ),
          ),
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => context.pop(),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  side: const BorderSide(color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        );
}
