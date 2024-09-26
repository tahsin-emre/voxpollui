import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_list_view.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';

mixin CommunityListMixin on State<CommunityListView> {
  late final _communityCubit = context.read<CommunityCubit>();

  @override
  void initState() {
    super.initState();
    _communityCubit.fetchCommunityList();
  }

  void navToCreate() {
    const CommunityCreateRoute().push<void>(context);
  }
}
