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
  const CommunityDetailRoute(this.communityId);
  static const String path = '/community/detail';
  final String communityId;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: CommunityDetailView(communityId: communityId));
  }
}

@TypedGoRoute<CommunityEditRoute>(path: CommunityEditRoute.path)
class CommunityEditRoute extends GoRouteData {
  const CommunityEditRoute(this.$extra);
  static const String path = '/community/edit';
  final CommunityModel $extra;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: CommunityEditView(community: $extra));
  }
}
