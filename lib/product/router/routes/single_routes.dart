part of '../route_tree.dart';

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const String path = '/';
  static final $parentNavigatorKey = AppRouter.rootNavigatorKey;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const SplashView());
  }
}
