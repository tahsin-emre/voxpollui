import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/owner_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';

final class PollUserTile extends StatelessWidget {
  const PollUserTile(this.owner, {super.key});
  final OwnerModel owner;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (owner.ownerType == OwnerType.user) {
              final user = owner as UserModel;
              UserProfileRoute(uid: user.id).push<void>(context);
              return;
            }
            if (owner.ownerType == OwnerType.community) {
              final community = owner as CommunityModel;
              CommunityDetailRoute(community.id).push<void>(context);
              return;
            }
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.black,
            backgroundImage:
                owner.imageUrl != null ? NetworkImage(owner.imageUrl!) : null,
            child: owner.imageUrl == null
                ? owner.ownerType == OwnerType.user
                    ? IconConstants.profile.toIcon
                    : IconConstants.community.toIcon
                : null,
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
                    owner.name ?? '',
                    style: TextStyle(
                      fontFamily: FontConstants.gilroySemibold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconConstants.verify.toCustomIcon(size: 20),
                  const SizedBox(width: 5),
                  Text(
                    '@${owner.userName}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.opposite,
                      fontFamily: FontConstants.gilroySemibold,
                    ),
                  ),
                ],
              ),
              Text(
                owner.ownerType == OwnerType.user
                    ? LocaleKeys.home_drawer_followerText.tr(
                        args: [
                          (owner as UserModel).followersCount.toString(),
                        ],
                      )
                    : LocaleKeys.community_xMembers.tr(
                        args: [
                          (owner as CommunityModel).memberCount.toString(),
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
          onTap: () {},
          child: IconConstants.more.toIcon,
        ),
      ],
    );
  }
}
