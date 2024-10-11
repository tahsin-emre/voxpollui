// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_tree.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $loginRoute,
      $registerRoute,
      $onboardRoute,
      $communityCreateRoute,
      $communityDetailRoute,
      $homeShellRoute,
      $pollCreateRoute,
      $pollDetailsRoute,
      $splashRoute,
      $documentReaderRoute,
      $userProfileRoute,
    ];

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/auth/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/auth/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute => GoRouteData.$route(
      path: '/auth/register',
      factory: $RegisterRouteExtension._fromState,
    );

extension $RegisterRouteExtension on RegisterRoute {
  static RegisterRoute _fromState(GoRouterState state) => RegisterRoute(
        state.extra as UserModel,
      );

  String get location => GoRouteData.$location(
        '/auth/register',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $onboardRoute => GoRouteData.$route(
      path: '/onboard',
      factory: $OnboardRouteExtension._fromState,
    );

extension $OnboardRouteExtension on OnboardRoute {
  static OnboardRoute _fromState(GoRouterState state) => const OnboardRoute();

  String get location => GoRouteData.$location(
        '/onboard',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $communityCreateRoute => GoRouteData.$route(
      path: '/community/create',
      factory: $CommunityCreateRouteExtension._fromState,
    );

extension $CommunityCreateRouteExtension on CommunityCreateRoute {
  static CommunityCreateRoute _fromState(GoRouterState state) =>
      const CommunityCreateRoute();

  String get location => GoRouteData.$location(
        '/community/create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $communityDetailRoute => GoRouteData.$route(
      path: '/community/detail',
      factory: $CommunityDetailRouteExtension._fromState,
    );

extension $CommunityDetailRouteExtension on CommunityDetailRoute {
  static CommunityDetailRoute _fromState(GoRouterState state) =>
      CommunityDetailRoute(
        state.extra as CommunityModel,
      );

  String get location => GoRouteData.$location(
        '/community/detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $homeShellRoute => ShellRouteData.$route(
      navigatorKey: HomeShellRoute.$navigatorKey,
      factory: $HomeShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/home/feed',
          parentNavigatorKey: FeedRoute.$parentNavigatorKey,
          factory: $FeedRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/home/discover',
          parentNavigatorKey: DiscoverRoute.$parentNavigatorKey,
          factory: $DiscoverRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/home/myProfile',
          parentNavigatorKey: MyProfileRoute.$parentNavigatorKey,
          factory: $MyProfileRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/home/community',
          parentNavigatorKey: CommunityRoute.$parentNavigatorKey,
          factory: $CommunityRouteExtension._fromState,
        ),
      ],
    );

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

extension $FeedRouteExtension on FeedRoute {
  static FeedRoute _fromState(GoRouterState state) => const FeedRoute();

  String get location => GoRouteData.$location(
        '/home/feed',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DiscoverRouteExtension on DiscoverRoute {
  static DiscoverRoute _fromState(GoRouterState state) => const DiscoverRoute();

  String get location => GoRouteData.$location(
        '/home/discover',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MyProfileRouteExtension on MyProfileRoute {
  static MyProfileRoute _fromState(GoRouterState state) => MyProfileRoute(
        state.extra as String,
      );

  String get location => GoRouteData.$location(
        '/home/myProfile',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $CommunityRouteExtension on CommunityRoute {
  static CommunityRoute _fromState(GoRouterState state) =>
      const CommunityRoute();

  String get location => GoRouteData.$location(
        '/home/community',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pollCreateRoute => GoRouteData.$route(
      path: '/poll/create',
      factory: $PollCreateRouteExtension._fromState,
    );

extension $PollCreateRouteExtension on PollCreateRoute {
  static PollCreateRoute _fromState(GoRouterState state) =>
      const PollCreateRoute();

  String get location => GoRouteData.$location(
        '/poll/create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pollDetailsRoute => GoRouteData.$route(
      path: '/poll/details',
      factory: $PollDetailsRouteExtension._fromState,
    );

extension $PollDetailsRouteExtension on PollDetailsRoute {
  static PollDetailsRoute _fromState(GoRouterState state) => PollDetailsRoute(
        state.extra as PollExtra,
      );

  String get location => GoRouteData.$location(
        '/poll/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $documentReaderRoute => GoRouteData.$route(
      path: '/documentReader',
      factory: $DocumentReaderRouteExtension._fromState,
    );

extension $DocumentReaderRouteExtension on DocumentReaderRoute {
  static DocumentReaderRoute _fromState(GoRouterState state) =>
      DocumentReaderRoute(
        state.extra as DocumentModel,
      );

  String get location => GoRouteData.$location(
        '/documentReader',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $userProfileRoute => GoRouteData.$route(
      path: '/userProfile',
      factory: $UserProfileRouteExtension._fromState,
    );

extension $UserProfileRouteExtension on UserProfileRoute {
  static UserProfileRoute _fromState(GoRouterState state) => UserProfileRoute(
        uid: state.uri.queryParameters['uid']!,
      );

  String get location => GoRouteData.$location(
        '/userProfile',
        queryParams: {
          'uid': uid,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
