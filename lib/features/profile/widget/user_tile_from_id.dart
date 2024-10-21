import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/extensions/context_ext.dart';

final class UserTileFromId extends StatelessWidget {
  const UserTileFromId(this.userId, {super.key});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getUser(userId),
      builder: (_, snapshot) {
        final user = snapshot.data;
        return Padding(
          padding: PagePaddings.allM,
          child: Skeletonizer(
            enabled: snapshot.data == null,
            child: GestureDetector(
              onTap: () {
                if (user == null) return;
                UserProfileRoute(uid: user.id).push<void>(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColor.black,
                    backgroundImage: user?.imageUrl != null
                        ? NetworkImage(user?.imageUrl ?? '')
                        : null,
                    child: user?.imageUrl == null
                        ? IconConstants.profile.toIcon
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user?.name ?? '',
                              style: TextStyle(
                                fontFamily: FontConstants.gilroySemibold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            IconConstants.verify.toCustomIcon(size: 20),
                            const SizedBox(width: 5),
                            Text(
                              '@${user?.userName}',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.opposite,
                                fontFamily: FontConstants.gilroySemibold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          LocaleKeys.home_drawer_followerText.tr(
                            args: [
                              (user?.followersCount ?? 0).toString(),
                            ],
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontConstants.gilroyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.showSheet(
                        BottomSheet(
                          onClosing: () {},
                          builder: (_) => const SafeArea(
                            top: false,
                            left: false,
                            right: false,
                            child: Text('data'),
                          ),
                        ),
                      );
                    },
                    child: IconConstants.more.toIcon,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
