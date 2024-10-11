part of '../route_tree.dart';

@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<FeedRoute>(path: FeedRoute.path),
    TypedGoRoute<DiscoverRoute>(path: DiscoverRoute.path),
    TypedGoRoute<MyProfileRoute>(path: MyProfileRoute.path),
    TypedGoRoute<CommunityRoute>(path: CommunityRoute.path),
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

final class DiscoverRoute extends GoRouteData {
  const DiscoverRoute();
  static const String path = '/home/discover';
  static final $parentNavigatorKey = AppRouter.homeShellKey;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const DiscoverView());
  }
}

final class MyProfileRoute extends GoRouteData {
  const MyProfileRoute(this.$extra);
  static const String path = '/home/myProfile';
  static final $parentNavigatorKey = AppRouter.homeShellKey;
  final String $extra;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: ProfileView(userId: $extra));
  }
}

final class CommunityRoute extends GoRouteData {
  const CommunityRoute();
  static const String path = '/home/community';
  static final $parentNavigatorKey = AppRouter.homeShellKey;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const CommunityListView());
  }
}
