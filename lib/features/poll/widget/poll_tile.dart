import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/poll/widget/poll_user_tile.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/owner_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/services/firebase/community_service.dart';
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
      future: getUser(),
      builder: (_, snapshot) {
        final owner = snapshot.data;
        return Skeletonizer(
          enabled: owner == null,
          child: Container(
            margin: PagePaddings.allS,
            padding: PagePaddings.allL,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (owner != null) PollUserTile(owner),
                const SizedBox(height: 10),
                if (owner != null) _PollTile(poll, owner),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<OwnerModel?> getUser() async {
    final userResponse = await UserService().getUser(poll.ownerId);
    if (userResponse != null) {
      return userResponse;
    }
    final communityResponse =
        await CommunityService().getCommunity(poll.ownerId);
    if (communityResponse != null) {
      return communityResponse;
    }
    return null;
  }
}

final class _PollTile extends StatelessWidget {
  const _PollTile(this.poll, this.owner);
  final PollModel poll;
  final OwnerModel owner;
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
          onPressed: () => PollDetailsRoute(PollExtra(poll: poll, owner: owner))
              .push<void>(context),
          text: LocaleKeys.base_join.tr(),
        ),
      ],
    );
  }
}
