import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/image_constants.dart';

final class CustomAppBar extends AppBar {
  CustomAppBar(
    BuildContext context, {
    String? title,
    bool isTransparent = false,
    super.actions,
    super.key,
  }) : super(
          scrolledUnderElevation: 0,
          forceMaterialTransparency: false,
          backgroundColor: isTransparent ? Colors.transparent : AppColor.white,
          elevation: 0,
          centerTitle: true,
          title: title == null
              ? Image.asset(ImageConstants.poll)
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: FontConstants.gilroyBold,
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
