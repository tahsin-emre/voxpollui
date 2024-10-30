import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/discover/mixin/discover_mixin.dart';
import 'package:voxpollui/features/poll/widget/poll_tile.dart';
import 'package:voxpollui/features/sub_features/common_widgets/app_search_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/owner_tile.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

part '../widget/discover_fields.dart';

final class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> with DiscoverMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: PagePaddings.allS,
        child: ListView(
          children: [
            AppSearchBar(
              onChanged: onSearch,
              label: LocaleKeys.base_search,
            ),
            Column(
              children: [
                _DiscoverTabView(
                  pageNotifier: pageNotifier,
                  onTap: (index) => pageNotifier.value = index,
                  users: users,
                  communities: communities,
                  polls: polls,
                ),
                Container(
                  margin: PagePaddings.allS,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.discover_title.tr(),
                    style: TextStyle(
                      fontFamily: FontConstants.gilroyBold,
                      fontSize: 24,
                    ),
                  ),
                ),
                ...discoverPolls.map(PollTile.new),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
