import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

final class IconConstants {
  const IconConstants._();
  static const error = Icons.error_outline;
  static const home = Icons.home_outlined;
  static const profile = Icons.person_outline;
  static const add = Icons.add_outlined;
  static const delete = Icons.delete_outline;
  static const notification = Icons.notifications_none_outlined;
  static const community = Icons.people_outline;
  static const search = Icons.search_outlined;
  static const more = Icons.more_vert_outlined;
  static const imageAdd = Icons.add_photo_alternate_outlined;
  static const verify = Icons.verified;
  static const settings = Icons.settings_outlined;
  static const arrowBack = Icons.arrow_back_outlined;
}

extension IconConstantsExt on IconData {
  Icon get toIcon {
    return Icon(
      this,
      size: WidgetSizes.x3L,
    );
  }

  Icon toSmallIcon() {
    return Icon(
      this,
      size: WidgetSizes.xxl,
    );
  }

  Icon toCustomIcon({
    double size = WidgetSizes.x3L,
    Color color = AppColor.primary,
  }) {
    return Icon(
      this,
      size: size,
      color: color,
    );
  }
}
