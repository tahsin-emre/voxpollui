import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_detail_view.dart';

mixin CommunityDetailMixin on State<CommunityDetailView> {
  late final _communityCubit = context.read<CommunityCubit>();
  final isLoadingNotifier = ValueNotifier<bool>(false);
  final pageNotifier = ValueNotifier<int>(0);

  Future<void> getPolls() async {
    isLoadingNotifier.value = true;
    await _communityCubit.getPolls(widget.community.id);
    isLoadingNotifier.value = false;
  }
}
