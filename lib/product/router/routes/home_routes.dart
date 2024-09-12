part of '../route_tree.dart';

@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<FeedRoute>(path: FeedRoute.path),
  ],
)
final class HomeShellRoute extends ShellRouteData {
  const HomeShellRoute();
  static final $navigatorKey = AppRouter.homeShellKey;
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return HomeView(navigator);
  }
}

final class FeedRoute extends GoRouteData {
  const FeedRoute();
  static const String path = '/home/feed';
  static final $parentNavigatorKey = AppRouter.homeShellKey;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const FeedView());
  }
}
