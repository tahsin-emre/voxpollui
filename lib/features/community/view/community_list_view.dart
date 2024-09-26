import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_state.dart';
import 'package:voxpollui/features/community/mixin/community_list_mixin.dart';
import 'package:voxpollui/features/community/widget/community_card.dart';

class CommunityListView extends StatefulWidget {
  const CommunityListView({super.key});

  @override
  State<CommunityListView> createState() => _CommunityListViewState();
}

class _CommunityListViewState extends State<CommunityListView>
    with CommunityListMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (_, state) {
        final list = state.communityList ?? [];
        return Skeletonizer(
          enabled: state.isLoading,
          child: ListView(
            children: [...list.map(CommunityCard.new)],
          ),
        );
      },
    );
  }
}
