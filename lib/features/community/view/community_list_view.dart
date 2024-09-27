import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_state.dart';
import 'package:voxpollui/features/community/mixin/community_list_mixin.dart';
import 'package:voxpollui/features/community/widget/community_card.dart';
import 'package:voxpollui/features/community/widget/my_community_card.dart';
import 'package:voxpollui/features/sub_features/common_widgets/app_search_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

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
          final myList = state.myCommunityList ?? [];
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
                  onPressed: navToCreate,
                  text: LocaleKeys.community_createCommunity,
                ),
                Padding(
                  padding: PagePaddings.horL,
                  child: Text(
                    LocaleKeys.community_myCommunities.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontConstants.gilroyBold,
                    ),
                  ),
                ),
                ...myList.map(MyCommunityCard.new),
                const SizedBox(height: WidgetSizes.xl),
                Padding(
                  padding: PagePaddings.horL,
                  child: Text(
                    LocaleKeys.community_recomendedCommunities.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontConstants.gilroyBold,
                    ),
                  ),
                ),
                ...list.map(CommunityCard.new),
              ],
            ),
          );
        },
      ),
    );
  }
}
