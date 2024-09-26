import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({required this.user, required this.onDrawerTap, super.key});
  final UserModel user;
  final VoidCallback onDrawerTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.horL,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.feed_hello.tr(),
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: FontConstants.gilroyLight,
                ),
              ),
              Text(
                '${user.name} ${user.surname}',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: FontConstants.gilroyBold,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: IconConstants.notification.toIcon,
            onPressed: () {},
          ),
          IconButton(
            icon: user.imageUrl != null
                ? Image.network(
                    user.imageUrl!,
                    width: WidgetSizes.x3L,
                    height: WidgetSizes.x3L,
                  )
                : IconConstants.profile.toIcon,
            onPressed: onDrawerTap,
          ),
        ],
      ),
    );
  }
}
