import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/settings/cubit/settings_cubit.dart';
import 'package:voxpollui/features/settings/cubit/settings_state.dart';
import 'package:voxpollui/product/initialize/theme/app_theme.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (_, state) {
          return Switch(
            value: state.theme == AppTheme.light,
            onChanged: (newValue) {
              context
                  .read<SettingsCubit>()
                  .changeTheme(newValue ? AppTheme.light : AppTheme.dark);
            },
          );
        },
      ),
    );
  }
}
