import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_list_view.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';

mixin CommunityListMixin on State<CommunityListView> {
  late final _communityCubit = context.read<CommunityCubit>();
  late final _authCubit = context.read<AuthCubit>();

  @override
  void initState() {
    super.initState();
    pullCommunities();
  }

  Future<void> pullCommunities() async {
    await _communityCubit.fetchCommunityList(
      _authCubit.state.user!.id,
    );
  }

  void navToCreate() {
    const CommunityCreateRoute().push<void>(context);
  }
}
