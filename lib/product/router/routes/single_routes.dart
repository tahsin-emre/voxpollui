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

@TypedGoRoute<OnboardRoute>(path: OnboardRoute.path)
class OnboardRoute extends GoRouteData {
  const OnboardRoute();
  static const String path = '/onboard';
  static final $parentNavigatorKey = AppRouter.rootNavigatorKey;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const OnboardView());
  }
}
