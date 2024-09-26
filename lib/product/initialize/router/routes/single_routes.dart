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

@TypedGoRoute<DocumentReaderRoute>(path: DocumentReaderRoute.path)
class DocumentReaderRoute extends GoRouteData {
  const DocumentReaderRoute({required this.title, required this.content});
  static const String path = '/onboard';
  final String title;
  final String content;
  @override
  TPage buildPage(BuildContext context, GoRouterState state) {
    return TPage(child: DocumentReaderView(title: title, content: content));
  }
}
