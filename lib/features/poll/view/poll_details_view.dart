import 'package:flutter/material.dart';
import 'package:voxpollui/product/models/poll_model.dart';

class PollDetailsView extends StatefulWidget {
  const PollDetailsView({required this.poll, super.key});
  final PollModel poll;
  @override
  State<PollDetailsView> createState() => _PollDetailsViewState();
}

class _PollDetailsViewState extends State<PollDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.poll.id,
        ),
      ),
    );
  }
}
