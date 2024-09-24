import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/home/mixin/home_mixin.dart';
import 'package:voxpollui/features/home/view/home_inherited.dart';
import 'package:voxpollui/features/home/widgets/home_bottom_nav_bar.dart';
import 'package:voxpollui/features/home/widgets/home_drawer.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';

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
        appBar: AppBar(
          title: Text(LocaleKeys.appName.tr()),
        ),
        body: widget.child,
        endDrawer: HomeDrawer(user: user),
        bottomNavigationBar: HomeBottomNavBar(onTap: onPageChanged),
      ),
    );
  }
}
