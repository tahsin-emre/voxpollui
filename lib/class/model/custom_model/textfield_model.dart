import 'package:flutter/material.dart';
import 'dart:io';

class FieldOption {
  TextEditingController controller;
  File? image;

  FieldOption({String initialText = ''})
      : controller = TextEditingController(text: initialText);
}
