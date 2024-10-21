import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/discover/cubit/discover_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/profile/cubit/profile_cubit.dart';
import 'package:voxpollui/product/initialize/router/app_router.dart';
import 'package:voxpollui/product/initialize/theme/app_theme.dart';
import 'package:voxpollui/product/utils/constants/product_constants.dart';

final class MainApp extends StatelessWidget {
  const MainApp({required this.initialTheme, super.key});
  final AdaptiveThemeMode? initialTheme;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => PollCubit()),
        BlocProvider(create: (_) => CommunityCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => DiscoverCubit()),
      ],
      child: AdaptiveTheme(
        light: AppTheme.light,
        dark: AppTheme.dark,
        initial: initialTheme ?? AdaptiveThemeMode.light,
        builder: (lightTheme, darkTheme) => MaterialApp.router(
          title: ProductConstants.appName,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: AppRouter.config,
        ),
      ),
    );
  }
}
