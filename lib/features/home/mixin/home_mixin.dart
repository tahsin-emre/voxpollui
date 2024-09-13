import 'package:flutter/material.dart';
import 'package:voxpollui/features/home/view/home_view.dart';
import 'package:voxpollui/product/router/route_tree.dart';

mixin HomeMixin on State<HomeView> {
  void onPageChanged(int index) {
    if (index == 0) {
      const FeedRoute().go(context);
    } else if (index == 3) {
      const ProfileRoute().go(context);
    }
  }
}
