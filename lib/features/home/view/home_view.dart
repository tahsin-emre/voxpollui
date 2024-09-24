import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:voxpollui/features/home/mixin/home_mixin.dart';
import 'package:voxpollui/features/home/view/home_inherited.dart';
import 'package:voxpollui/features/home/widgets/home_drawer.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';

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
        appBar: AppBar(),
        key: scaffoldKey,
        body: widget.child,
        endDrawer: HomeDrawer(user: user),
        floatingActionButton: FloatingActionButton(
          onPressed: onCreatePoll,
          child: IconConstants.add.toIcon,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: HomeBottomNavBar(
          onTap: onPageChanged,
        ),
      ),
    );
  }
}

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({required this.onTap, super.key});
  final ValueChanged<int> onTap;

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      onTap: (index) {
        currentIndex = index;
        widget.onTap(index);
      },
      currentIndex: currentIndex,
      fabLocation: StylishBarFabLocation.center,
      items: [
        BottomBarItem(
          icon: IconConstants.home.toIcon,
          title: Text(LocaleKeys.feed_title.tr()),
        ),
        BottomBarItem(
          icon: IconConstants.error.toIcon,
          title: Text(LocaleKeys.appName.tr()),
        ),
        BottomBarItem(
          icon: IconConstants.error.toIcon,
          title: Text(LocaleKeys.appName.tr()),
        ),
        BottomBarItem(
          icon: IconConstants.profile.toIcon,
          title: Text(LocaleKeys.profile_title.tr()),
        ),
      ],
      option: AnimatedBarOptions(
        barAnimation: BarAnimation.blink,
        iconStyle: IconStyle.animated,
      ),
    );
  }
}
