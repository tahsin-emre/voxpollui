import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_detail_view.dart';

mixin CommunityDetailMixin on State<CommunityDetailView> {
  late final _authCubit = context.read<AuthCubit>();
  late final _communityCubit = context.read<CommunityCubit>();
  final isLoadingNotifier = ValueNotifier<bool>(false);
  final pageNotifier = ValueNotifier<int>(0);

  bool get isManager {
    if (_authCubit.state.user == null) return false;
    final result = widget.community.managerList
        ?.any((e) => e == _authCubit.state.user!.id);
    return result ?? false;
  }

  @override
  void initState() {
    super.initState();
    getPolls();
  }

  Future<void> getPolls() async {
    isLoadingNotifier.value = true;
    await _communityCubit.getPolls(widget.community.id);
    isLoadingNotifier.value = false;
  }
}
