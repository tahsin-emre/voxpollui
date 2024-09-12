import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/features/authentication/view/login_view.dart';
import 'package:voxpollui/product/router/app_router.dart';

part 'route_tree.g.dart';
part 'routes/auth_routes.dart';

final class TPage extends CustomTransitionPage<void> {
  TPage({
    required super.child,
  }) : super(
          transitionsBuilder: (_, animation, __, ___) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
