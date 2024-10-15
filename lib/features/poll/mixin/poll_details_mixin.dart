import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/poll/view/poll_details_view.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/poll/option_model.dart';
import 'package:voxpollui/product/services/firebase/poll_service.dart';

mixin PollDetailsMixin on State<PollDetailsView> {
  late final _authCubit = context.read<AuthCubit>();
  late final _pollService = PollService();
  late final userVoteNotifier = ValueNotifier<String?>(null);
  late final isLoadingNotifier = ValueNotifier<bool>(true);
  bool get isOwner => widget.poll.ownerId == _authCubit.state.user!.id;
  bool get isExpired => widget.poll.endAt?.isBefore(DateTime.now()) ?? false;
  List<OptionModel> get options => widget.poll.options ?? [];
  String? get imageUrl => widget.poll.imageUrl;

  String get timeLeft {
    final diff = widget.poll.endAt?.difference(DateTime.now());
    if (diff == null) return '';
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;
    if (days > 0) {
      return LocaleKeys.poll_timeLeftDay
          .tr(args: [days.toString(), hours.toString(), minutes.toString()]);
    }
    if (hours > 0) {
      return LocaleKeys.poll_timeLeftHour
          .tr(args: [hours.toString(), minutes.toString()]);
    }
    if (minutes > 0) {
      return LocaleKeys.poll_timeLeftMinute.tr(args: [minutes.toString()]);
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    checkUserVoted();
  }

  Future<bool> votePoll(PollOption pollOption, int totalVoteCount) async {
    final response = await _pollService.votePoll(
      widget.poll.id,
      _authCubit.state.user!.id,
      pollOption.id ?? 'unknown',
    );
    return response;
  }

  Future<void> checkUserVoted() async {
    final response = await _pollService.checkIfUserVoted(
      pollId: widget.poll.id,
      userId: _authCubit.state.user!.id,
    );
    userVoteNotifier.value = response;
    isLoadingNotifier.value = false;
  }
}
