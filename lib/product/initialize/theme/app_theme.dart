import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return ThemeData(
      primaryColor: AppColor.primary,
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColor.secondary,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: TextStyle(color: AppColor.white),
      ),
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
