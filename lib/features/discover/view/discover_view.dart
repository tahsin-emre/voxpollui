import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/sub_features/common_widgets/app_search_bar.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: PagePaddings.allL,
        children: [
          AppSearchBar(onChanged: (val) {}, label: LocaleKeys.base_search.tr()),
        ],
      ),
    );
  }
}
