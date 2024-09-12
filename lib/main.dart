import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/app.dart';
import 'package:voxpollui/git_secret/firebase_options.dart';
import 'package:voxpollui/product/localization/main_localization.dart';
import 'package:voxpollui/product/services/shared_preferences/shared_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedService.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainLocalization(child: const MainApp()));
}
