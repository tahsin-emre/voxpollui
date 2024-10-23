import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/community/mixin/community_detail_mixin.dart';
import 'package:voxpollui/features/community/widget/join_button.dart';
import 'package:voxpollui/features/poll/widget/poll_tile.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

part '../widget/community_fields.dart';

class CommunityDetailView extends StatefulWidget {
  const CommunityDetailView({required this.communityId, super.key});
  final String communityId;
  @override
  State<CommunityDetailView> createState() => _CommunityDetailViewState();
}

class _CommunityDetailViewState extends State<CommunityDetailView>
    with CommunityDetailMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoadingNotifier,
      builder: (_, isLoading, __) {
        return Skeletonizer(
          enabled: isLoading || community == null,
          child: Scaffold(
            floatingActionButton: _PollFab(
              isManager: isManager,
              communityId: widget.communityId,
            ),
            body: SingleChildScrollView(
              child: community == null
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        _CommunityImageHeader(
                          community!,
                          isManager: isManager,
                          onEdit: onEdit,
                        ),
                        _CommunityInfo(
                          community!,
                          isManager: isManager,
                          onJoin: onJoin,
                          pollCount: newPolls.length + oldPolls.length,
                        ),
                        const Divider(),
                        _CommunityTabNav(
                          pageNotifier,
                          (val) => pageNotifier.value = val,
                        ),
                        _CommunityTabView(
                          pageNotifier,
                          newPolls: newPolls,
                          oldPolls: oldPolls,
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

final class _PollFab extends StatelessWidget {
  const _PollFab({required this.isManager, required this.communityId});
  final bool isManager;
  final String communityId;
  @override
  Widget build(BuildContext context) {
    if (!isManager) return const SizedBox.shrink();
    return FloatingActionButton(
      onPressed: () {
        PollCreateRoute(ownerId: communityId).push<void>(context);
      },
      backgroundColor: AppColor.primary,
      child: const Icon(
        IconConstants.add,
        color: AppColor.white,
      ),
    );
  }
}
