import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

final class IconConstants {
  const IconConstants._();
  static const error = Icons.error_outline;
  static const home = Icons.home_outlined;
  static const profile = Icons.person_outline;
  static const add = Icons.add_outlined;
  static const notification = Icons.notifications_none_outlined;
  static const community = Icons.people_outline;
}

extension IconConstantsExt on IconData {
  Icon get toIcon {
    return Icon(
      this,
      size: WidgetSizes.x3L,
    );
  }
}
