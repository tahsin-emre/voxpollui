import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/router/route_tree.dart';

final class PollTile extends StatelessWidget {
  const PollTile(this.poll, {super.key});
  final PollModel poll;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(poll.title ?? ''),
        onTap: () => PollDetailsRoute(poll).push<void>(context),
      ),
    );
  }
}
