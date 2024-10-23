import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/discover/cubit/discover_cubit.dart';
import 'package:voxpollui/features/discover/view/discover_view.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/discover_service.dart';

mixin DiscoverMixin on State<DiscoverView> {
  late final _discoverCubit = context.read<DiscoverCubit>();
  final _discoverService = DiscoverService();
  final isLoadingNotifier = ValueNotifier<bool>(false);
  List<UserModel> users = [];
  List<PollModel> polls = [];
  List<CommunityModel> communities = [];

  @override
  void initState() {
    super.initState();
    _discoverCubit.reset();
  }

  Future<void> onSearch(String query) async {
    if (query.length < 3) {
      users.clear();
      polls.clear();
      communities.clear();
      setState(() {});
      return;
    }
    isLoadingNotifier.value = true;
    await onUserSearch(query);
    await onPollSearch(query);
    await onCommunitySearch(query);
    isLoadingNotifier.value = false;
  }

  Future<void> onUserSearch(String query) async {
    final response = await _discoverService.getUsers(query);
    users = response;
    setState(() {});
  }

  Future<void> onPollSearch(String query) async {
    final response = await _discoverService.getPolls(query);
    polls = response;
    setState(() {});
  }

  Future<void> onCommunitySearch(String query) async {
    final response = await _discoverService.getCommunities(query);
    communities = response;
    setState(() {});
  }
}
