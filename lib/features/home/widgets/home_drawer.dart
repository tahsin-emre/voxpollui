import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/home/widgets/theme_switch.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/auth_service.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    required this.user,
    super.key,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _DrawerHeader(user),
              const Divider(height: 20),
              _DrawerTile(
                onTap: () => MyProfileRoute(user.id).go(context),
                label: LocaleKeys.home_drawer_profile,
              ),
              _DrawerTile(
                onTap: () async {
                  await AuthService().signOut();
                  // ignore: use_build_context_synchronously
                  const SplashRoute().go(context);
                },
                label: LocaleKeys.auth_logout,
              ),
              _DrawerTile(
                onTap: () {},
                label: LocaleKeys.home_drawer_voxPollPro,
              ),
              _DrawerTile(
                onTap: () {},
                label: LocaleKeys.home_drawer_interests,
              ),
              _DrawerTile(
                onTap: () {},
                label: LocaleKeys.home_drawer_communities,
              ),
              _DrawerTile(
                onTap: () {},
                label: LocaleKeys.home_drawer_invite,
              ),
              const Divider(height: 20),
              _DrawerTile(onTap: () {}, label: LocaleKeys.home_drawer_tools),
              _DrawerTile(onTap: () {}, label: LocaleKeys.home_drawer_payments),
              _DrawerTile(onTap: () {}, label: LocaleKeys.home_drawer_settings),
              _DrawerTile(onTap: () {}, label: LocaleKeys.home_drawer_faq),
              const ThemeSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}

final class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader(this.user);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.black,
            backgroundImage:
                user.imageUrl != null ? NetworkImage(user.imageUrl!) : null,
            child: user.imageUrl == null ? IconConstants.profile.toIcon : null,
          ),
          const SizedBox(height: 10),
          Text(
            '${user.name} ${user.surname}',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontFamily: FontConstants.gilroyBold,
              fontSize: 18,
            ),
          ),
          Text(
            '@${user.userName}',
            textAlign: TextAlign.right,
            style: const TextStyle(color: AppColor.opposite, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.home_drawer_followingText.tr(
                  args: [user.followingCount.toString()],
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: FontConstants.gilroyMedium,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                LocaleKeys.home_drawer_followerText.tr(
                  args: [user.followersCount.toString()],
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: FontConstants.gilroyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _DrawerTile extends StatelessWidget {
  const _DrawerTile({required this.onTap, required this.label});
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          label.tr(),
          style: TextStyle(
            fontFamily: FontConstants.gilroyBold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
