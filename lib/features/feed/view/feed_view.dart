import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/feed/mixin/feed_mixin.dart';
import 'package:voxpollui/features/feed/widgets/feed_header.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_state.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/router/route_tree.dart';

final class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> with FeedMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoadingNotifier,
      builder: (_, isLoading, __) {
        if (isLoading) return const CircularProgressIndicator();
        return ListView(
          children: [
            const FeedHeader(),
            BlocSelector<PollCubit, PollState, List<PollModel>?>(
              selector: (state) => state.pollList,
              builder: (_, polls) {
                return Column(
                  children: polls?.map(_PollTile.new).toList() ?? [],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _PollTile extends StatelessWidget {
  const _PollTile(this.poll);
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
