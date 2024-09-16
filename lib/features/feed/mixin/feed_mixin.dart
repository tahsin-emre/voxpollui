import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/feed/view/feed_view.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';

mixin FeedMixin on State<FeedView> {
  late final _pollCubit = context.read<PollCubit>();
  final isLoadingNotifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    getFeed();
  }

  Future<void> getFeed() async {
    isLoadingNotifier.value = true;
    await _pollCubit.getPolls();
    isLoadingNotifier.value = false;
  }
}
