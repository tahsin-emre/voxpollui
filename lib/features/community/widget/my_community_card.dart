import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/community/community_model.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';

final class MyCommunityCard extends StatelessWidget {
  const MyCommunityCard(this.community, {super.key});
  final CommunityModel community;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: community.imageUrl == null
          ? IconConstants.community.toIcon
          : CircleAvatar(
              backgroundImage: NetworkImage(community.imageUrl ?? ''),
            ),
      title: Row(
        children: [
          Text('${community.name}'),
          const SizedBox(width: 4),
          const Icon(Icons.check_circle, color: AppColor.primary, size: 16),
          const SizedBox(width: 4),
          Text(
            '@${community.userName}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      subtitle: Text(
        LocaleKeys.community_xMembers.tr(args: ['${community.memberCount}']),
      ),
      trailing: InkWell(
        onTap: () {},
        child: IconConstants.more.toIcon,
      ),
    );
  }
}
