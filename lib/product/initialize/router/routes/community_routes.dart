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
