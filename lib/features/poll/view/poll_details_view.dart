import 'package:flutter/material.dart';
import 'package:voxpollui/features/poll/mixin/poll_details_mixin.dart';
import 'package:voxpollui/product/models/poll/poll_model.dart';

class PollDetailsView extends StatefulWidget {
  const PollDetailsView({required this.poll, super.key});
  final PollModel poll;
  @override
  State<PollDetailsView> createState() => _PollDetailsViewState();
}

class _PollDetailsViewState extends State<PollDetailsView>
    with PollDetailsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: isLoadingNotifier,
          builder: (_, isLoading, __) {
            return Text(
              widget.poll.id,
            );
          },
        ),
      ),
    );
  }
}
