import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
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
      onTap: () => CommunityDetailRoute(widget.community).push<void>(context),
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
      trailing: Skeletonizer(
        enabled: isLoading,
        child: TextButton(
          onPressed: () async {
            setState(() => isLoading = true);
            final authCubit = context.read<AuthCubit>();
            final communityCubit = context.read<CommunityCubit>();
            if (authCubit.state.user == null) return;
            await communityCubit.joinCommunity(
              authCubit.state.user!.id,
              widget.community.id,
            );
          },
          child: Text(LocaleKeys.base_join.tr()),
        ),
      ),
    );
  }
}
