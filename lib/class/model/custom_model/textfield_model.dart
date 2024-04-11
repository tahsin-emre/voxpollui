import 'dart:io';

import 'package:flutter/material.dart';

class FieldOption {
  TextEditingController controller;
  File? image;

  FieldOption({String initialText = ''})
      : controller = TextEditingController(text: initialText);
}