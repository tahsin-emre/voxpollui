import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/poll/mixin/poll_details_mixin.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/owner_tile.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/owner_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

part '../widget/poll_details_fields.dart';

class PollDetailsView extends StatefulWidget {
  const PollDetailsView({required this.poll, required this.owner, super.key});
  final PollModel poll;
  final OwnerModel owner;
  @override
  State<PollDetailsView> createState() => _PollDetailsViewState();
}

class _PollDetailsViewState extends State<PollDetailsView>
    with PollDetailsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: ValueListenableBuilder(
        valueListenable: isLoadingNotifier,
        builder: (_, isLoading, __) {
          return Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: PagePaddings.horL,
              child: ListView(
                children: [
                  OwnerTile(
                    owner: widget.owner,
                    pollId: widget.poll.id,
                  ),
                  const SizedBox(height: WidgetSizes.xxl),
                  if (imageUrl != null)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          imageUrl!,
                          height: WidgetSizes.maxiL,
                          cacheHeight: WidgetSizes.maxiL.toInt(),
                        ),
                      ),
                    ),
                  const SizedBox(height: WidgetSizes.m),
                  _TimesLeft(isExpired: isExpired, timeLeft: timeLeft),
                  const SizedBox(height: WidgetSizes.m),
                  ValueListenableBuilder(
                    valueListenable: userVoteNotifier,
                    builder: (_, userVote, __) {
                      return FlutterPolls(
                        pollId: widget.poll.id,
                        hasVoted: userVote != null,
                        userToVote: userVote,
                        userVotedOptionId: userVote,
                        pollStartDate: widget.poll.createdAt,
                        votesText: LocaleKeys.poll_voted.tr(),
                        onVoted: votePoll,
                        pollEnded: userVote != null || isExpired,
                        pollTitle: _PollTitle(widget.poll.title ?? ''),
                        votedPercentageTextStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: FontConstants.gilroySemibold,
                        ),
                        pollOptions: options
                            .map(
                              (e) => PollOption(
                                id: e.id,
                                title: Text(
                                  e.optionText ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: FontConstants.gilroyBold,
                                  ),
                                ),
                                votes: (e.voteCount ?? 0).toInt(),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
