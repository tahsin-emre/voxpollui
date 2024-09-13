import 'package:flutter/material.dart';
import 'package:voxpollui/features/poll/view/poll_details_view.dart';

mixin PollDetailsMixin on State<PollDetailsView> {
  final isLoadingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    isLoadingNotifier.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoadingNotifier.value = false;
    });
  }
}
