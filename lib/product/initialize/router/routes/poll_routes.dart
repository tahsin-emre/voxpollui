part of '../route_tree.dart';

@TypedGoRoute<PollCreateRoute>(path: PollCreateRoute.path)
class PollCreateRoute extends GoRouteData {
  const PollCreateRoute();
  static const String path = '/poll/create';
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: const PollCreateView());
  }
}

@TypedGoRoute<PollDetailsRoute>(path: PollDetailsRoute.path)
class PollDetailsRoute extends GoRouteData {
  const PollDetailsRoute(this.$extra);
  static const String path = '/poll/details';
  final PollExtra $extra;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: PollDetailsView(poll: $extra.poll, user: $extra.user));
  }
}

final class PollExtra extends Equatable {
  const PollExtra({required this.poll, required this.user});
  final PollModel poll;
  final UserModel user;

  @override
  List<Object?> get props => [poll, user];
}
