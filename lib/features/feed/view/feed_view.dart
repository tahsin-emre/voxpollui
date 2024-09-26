import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/feed/mixin/feed_mixin.dart';
import 'package:voxpollui/features/feed/widgets/feed_header.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_state.dart';
import 'package:voxpollui/features/poll/widget/poll_tile.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

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
        return SafeArea(
          child: Skeletonizer(
            enabled: isLoading,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    FeedHeader(
                      user: user,
                      onDrawerTap: openDrawer,
                    ),
                    const SizedBox(height: WidgetSizes.l),
                    BlocSelector<PollCubit, PollState, List<PollModel>?>(
                      selector: (state) => state.pollList,
                      builder: (_, polls) {
                        if (polls?.isEmpty ?? true) {
                          return const Center(child: Text('No Polls'));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: polls!.length,
                          itemBuilder: (_, index) => PollTile(polls[index]),
                        );
                      },
                    ),
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
