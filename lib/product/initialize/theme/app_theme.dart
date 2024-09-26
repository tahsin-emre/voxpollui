import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return ThemeData(
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
