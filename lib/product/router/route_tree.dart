import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/features/authentication/view/login_view.dart';
import 'package:voxpollui/features/authentication/view/register_view.dart';
import 'package:voxpollui/features/feed/view/feed_view.dart';
import 'package:voxpollui/features/home/view/home_view.dart';
import 'package:voxpollui/features/onboarding/view/onboard_view.dart';
import 'package:voxpollui/features/splash/view/splash_view.dart';
import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/router/app_router.dart';

part 'route_tree.g.dart';
part 'routes/auth_routes.dart';
part 'routes/home_routes.dart';
part 'routes/single_routes.dart';

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
