import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/community/widget/join_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';

final class CommunityCard extends StatefulWidget {
  const CommunityCard(this.community, {super.key});
  final CommunityModel community;

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          CommunityDetailRoute(widget.community.id).push<void>(context),
      leading: CircleAvatar(
        backgroundImage: widget.community.imageUrl != null
            ? NetworkImage(widget.community.imageUrl!)
            : null,
        child: widget.community.imageUrl == null
            ? IconConstants.community.toIcon
            : null,
      ),
      title: Row(
        children: [
          Text('${widget.community.name}'),
          const SizedBox(width: 4),
          const Icon(Icons.check_circle, color: AppColor.primary, size: 16),
        ],
      ),
      subtitle: Text(
        LocaleKeys.community_xMembers
            .tr(args: ['${widget.community.memberCount}']),
      ),
      trailing: JoinButton(
        communityId: widget.community.id,
        onJoin: (i) {},
      ),
    );
  }
}
