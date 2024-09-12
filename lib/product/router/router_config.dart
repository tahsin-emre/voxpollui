import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  const AppRouter._();
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter config = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [],
  );
}
