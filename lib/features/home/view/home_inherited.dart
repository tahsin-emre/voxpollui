import 'package:flutter/material.dart';
import 'package:voxpollui/features/home/view/home_view.dart';

final class HomeInherited extends InheritedWidget {
  const HomeInherited({
    required super.child,
    required this.state,
    super.key,
  });
  final HomeViewState state;

  static HomeInherited of(BuildContext context) {
    final homeInherited =
        context.dependOnInheritedWidgetOfExactType<HomeInherited>();
    assert(!(homeInherited == null), 'No HomeInherited found in context');
    return homeInherited!;
  }

  @override
  bool updateShouldNotify(HomeInherited oldWidget) => false;
}
