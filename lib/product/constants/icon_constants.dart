import 'package:flutter/material.dart';

final class IconConstants {
  const IconConstants._();
  static const home = Icons.home;
  static const profile = Icons.person;
}

extension IconConstantsExt on IconData {
  Icon get toIcon {
    return Icon(this);
  }
}
