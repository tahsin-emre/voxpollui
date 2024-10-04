import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    final themeOf = AdaptiveTheme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: ValueListenableBuilder(
        valueListenable: themeOf.modeChangeNotifier,
        builder: (_, mode, __) {
          return Switch(
            value: mode == AdaptiveThemeMode.light,
            onChanged: (value) {
              if (value) {
                themeOf.setLight();
                return;
              }
              themeOf.setDark();
            },
          );
        },
      ),
    );
  }
}
