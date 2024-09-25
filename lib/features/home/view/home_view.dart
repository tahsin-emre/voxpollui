import 'package:flutter/material.dart';
import 'package:voxpollui/features/home/mixin/home_mixin.dart';
import 'package:voxpollui/features/home/view/home_inherited.dart';
import 'package:voxpollui/features/home/widgets/home_bottom_nav_bar.dart';
import 'package:voxpollui/features/home/widgets/home_drawer.dart';

final class HomeView extends StatefulWidget {
  const HomeView(this.child, {super.key});
  final Widget child;
  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return HomeInherited(
      state: this,
      child: Scaffold(
        key: scaffoldKey,
        body: widget.child,
        endDrawer: HomeDrawer(user: user),
        bottomNavigationBar: HomeBottomNavBar(
          onTap: onPageChanged,
          onAdd: onAdd,
        ),
      ),
    );
  }
}
