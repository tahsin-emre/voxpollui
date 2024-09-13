import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/home/mixin/home_mixin.dart';
import 'package:voxpollui/product/constants/icon_constants.dart';
import 'package:voxpollui/product/localization/locale_keys.g.dart';

final class HomeView extends StatefulWidget {
  const HomeView(this.child, {super.key});
  final Widget child;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconConstants.home.toIcon,
            label: LocaleKeys.feed_title.tr(),
          ),
          BottomNavigationBarItem(
            icon: IconConstants.profile.toIcon,
            label: LocaleKeys.profile_title.tr(),
          ),
        ],
      ),
    );
  }
}
