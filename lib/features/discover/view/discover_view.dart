import 'package:flutter/material.dart';
import 'package:voxpollui/features/discover/mixin/discover_mixin.dart';
import 'package:voxpollui/features/poll/widget/poll_tile.dart';
import 'package:voxpollui/features/sub_features/common_widgets/app_search_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/owner_tile.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> with DiscoverMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: PagePaddings.allM,
        child: Column(
          children: [
            AppSearchBar(
              onChanged: onSearch,
              label: LocaleKeys.base_search,
            ),
            Expanded(
              child: Column(
                children: [
                  ...users.map(
                    (e) => Padding(
                      padding: PagePaddings.allS,
                      child: OwnerTile(owner: e),
                    ),
                  ),
                  const Divider(),
                  ...communities.map(
                    (e) => Padding(
                      padding: PagePaddings.allS,
                      child: OwnerTile(owner: e),
                    ),
                  ),
                  const Divider(),
                  ...polls.map(PollTile.new),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _TabListView extends StatelessWidget {
  const _TabListView({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}
