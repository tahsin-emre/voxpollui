import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

final class PollTile extends StatelessWidget {
  const PollTile(this.poll, {super.key});
  final PollModel poll;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getUser(poll.ownerId),
      builder: (_, snapshot) {
        final user = snapshot.data;
        return Skeletonizer(
          enabled: user == null,
          child: Container(
            margin: PagePaddings.allS,
            padding: PagePaddings.allL,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user != null) _UserTile(user),
                const SizedBox(height: 10),
                _PollTile(poll),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PollTile extends StatelessWidget {
  const _PollTile(this.poll);
  final PollModel poll;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          poll.title ?? '',
          style: TextStyle(
            fontSize: 18,
            fontFamily: FontConstants.gilroyBold,
          ),
        ),
        const SizedBox(height: WidgetSizes.s),
        Text(
          '${poll.options?.length ?? 0} kişi katıldı',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.black,
            fontFamily: FontConstants.gilroyLight,
          ),
        ),
        const SizedBox(height: WidgetSizes.s),
        ExtendedElevatedButton(
          onPressed: () {},
          text: LocaleKeys.base_join,
        ),
      ],
    );
  }
}

final class _UserTile extends StatelessWidget {
  const _UserTile(this.user);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.black,
            backgroundImage:
                user.imageUrl != null ? NetworkImage(user.imageUrl!) : null,
            child: user.imageUrl == null ? IconConstants.profile.toIcon : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    user.name ?? '',
                    style: TextStyle(
                      fontFamily: FontConstants.gilroySemibold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconConstants.verify.toCustomIcon(size: 20),
                  const SizedBox(width: 5),
                  Text(
                    '@${user.userName}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.opposite,
                      fontFamily: FontConstants.gilroySemibold,
                    ),
                  ),
                ],
              ),
              Text(
                '${user.followersCount} Takipçi',
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
          onTap: () {},
          child: IconConstants.more.toIcon,
        ),
      ],
    );
  }
}
