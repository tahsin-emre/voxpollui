import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_state.dart';
import 'package:voxpollui/features/community/mixin/community_list_mixin.dart';
import 'package:voxpollui/features/community/widget/community_card.dart';
import 'package:voxpollui/features/sub_features/app_search/view/app_search_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

class CommunityListView extends StatefulWidget {
  const CommunityListView({super.key});

  @override
  State<CommunityListView> createState() => _CommunityListViewState();
}

class _CommunityListViewState extends State<CommunityListView>
    with CommunityListMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CommunityCubit, CommunityState>(
        builder: (_, state) {
          final list = state.communityList ?? [];
          return Skeletonizer(
            enabled: state.isLoading,
            child: ListView(
              padding: PagePaddings.allL,
              children: [
                AppSearchBar(
                  onChanged: (value) {},
                  label: LocaleKeys.community_communitySearch,
                ),
                ExtendedElevatedButton(
                    onPressed: () {},
                    text: LocaleKeys.community_createCommunity),
                ...list.map(CommunityCard.new),
              ],
            ),
          );
        },
      ),
    );
  }
}
