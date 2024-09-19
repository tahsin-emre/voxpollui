part of '../route_tree.dart';

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const String path = '/';
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const SplashView());
  }
}

@TypedGoRoute<OnboardRoute>(path: OnboardRoute.path)
class OnboardRoute extends GoRouteData {
  const OnboardRoute();
  static const String path = '/onboard';
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const Page0());
  }
}
