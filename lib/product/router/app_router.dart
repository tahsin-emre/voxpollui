import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/product/router/route_tree.dart';

final class AppRouter {
  const AppRouter._();
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final config = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: LoginRoute.path,
    routes: $appRoutes,
  );
}
