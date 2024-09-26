part of '../route_tree.dart';

@TypedGoRoute<LoginRoute>(path: LoginRoute.path)
class LoginRoute extends GoRouteData {
  const LoginRoute();
  static const String path = '/auth/login';
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const LoginView());
  }
}

@TypedGoRoute<RegisterRoute>(path: RegisterRoute.path)
class RegisterRoute extends GoRouteData {
  const RegisterRoute(this.$extra);
  static const String path = '/auth/register';
  final UserModel $extra;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: RegisterView(user: $extra));
  }
}

@TypedGoRoute<OnboardRoute>(path: OnboardRoute.path)
class OnboardRoute extends GoRouteData {
  const OnboardRoute();
  static const String path = '/onboard';
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const OnboardView());
  }
}
