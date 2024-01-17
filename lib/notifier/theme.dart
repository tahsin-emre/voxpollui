import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class ThemeNotifier with ChangeNotifier {
  ThemeData currentTheme;
  bool _darkMode; // dark mode durumu için özel değişken
 
  bool get isDarkMode => _darkMode;
 
  ThemeNotifier()
      : currentTheme = ThemeData.light(),
        _darkMode = false;
 
  void initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
    _darkMode = isDarkMode; // darkMode değerini güncelle
    notifyListeners();
  }
 
  void toggleTheme() async {
    _darkMode = !_darkMode;
    currentTheme = _darkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
 
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _darkMode);
  }
}