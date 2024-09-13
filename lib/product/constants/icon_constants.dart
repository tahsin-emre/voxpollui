import 'package:flutter/material.dart';

final class IconConstants {
  const IconConstants._();
  static const error = Icons.error;
  static const home = Icons.home;
  static const profile = Icons.person;
  static const add = Icons.add;
}

extension IconConstantsExt on IconData {
  Icon get toIcon {
    return Icon(this);
  }
}
