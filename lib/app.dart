import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/settings/cubit/settings_cubit.dart';
import 'package:voxpollui/features/settings/cubit/settings_state.dart';
import 'package:voxpollui/product/initialize/router/app_router.dart';
import 'package:voxpollui/product/initialize/theme/app_theme.dart';
import 'package:voxpollui/product/utils/constants/product_constants.dart';

final class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => PollCubit()),
        BlocProvider(create: (_) => CommunityCubit()),
        BlocProvider(create: (_) => SettingsCubit()),
      ],
      child: BlocSelector<SettingsCubit, SettingsState, ThemeData?>(
        selector: (state) => state.theme,
        builder: (_, theme) {
          return MaterialApp.router(
            title: ProductConstants.appName,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: theme ?? AppTheme.light,
            routerConfig: AppRouter.config,
          );
        },
      ),
    );
  }
}
