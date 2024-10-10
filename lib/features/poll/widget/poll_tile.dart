import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/profile/widget/user_tile.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
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
                if (user != null) UserTile(user),
                const SizedBox(height: 10),
                if (user != null) _PollTile(poll, user),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<UserModel?> getUser(String userId) async {
    return UserService().getUser(userId);
  }
}

class _PollTile extends StatelessWidget {
  const _PollTile(this.poll, this.user);
  final PollModel poll;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    num userVoted = 0;
    poll.options?.forEach((e) => userVoted += e.voteCount ?? 0);
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
          LocaleKeys.poll_xUserJoined.tr(args: [userVoted.toString()]),
          style: TextStyle(
            fontSize: 14,
            color: AppColor.black,
            fontFamily: FontConstants.gilroyLight,
          ),
        ),
        const SizedBox(height: WidgetSizes.s),
        ExtendedElevatedButton(
          onPressed: () => PollDetailsRoute(PollExtra(poll: poll, user: user))
              .push<void>(context),
          text: LocaleKeys.base_join.tr(),
        ),
      ],
    );
  }
}
