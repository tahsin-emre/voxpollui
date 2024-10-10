part of '../route_tree.dart';

@TypedGoRoute<CommunityCreateRoute>(path: CommunityCreateRoute.path)
class CommunityCreateRoute extends GoRouteData {
  const CommunityCreateRoute();
  static const String path = '/community/create';
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const CommunityCreateView());
  }
}

@TypedGoRoute<CommunityDetailRoute>(path: CommunityDetailRoute.path)
class CommunityDetailRoute extends GoRouteData {
  const CommunityDetailRoute(this.$extra);
  static const String path = '/community/detail';
  final CommunityModel $extra;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: CommunityDetailView(community: $extra));
  }
}
