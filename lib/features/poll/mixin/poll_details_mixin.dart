import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/poll/view/poll_details_view.dart';
import 'package:voxpollui/product/services/firebase/poll_service.dart';

mixin PollDetailsMixin on State<PollDetailsView> {
  late final _authCubit = context.read<AuthCubit>();
  late final _pollService = PollService();
  bool userVoted = false;

  @override
  void initState() {
    super.initState();
    getPollDetails();
  }

  Future<void> getPollDetails() async {
    await checkUserVoted();
  }

  Future<void> votePoll(String optionId) async {
    await _pollService.votePoll(
      widget.poll.id,
      _authCubit.state.user!.id,
      optionId,
    );
    await checkUserVoted();
    setState(() {});
  }

  Future<void> checkUserVoted() async {
    userVoted = await _pollService.checkIfUserVoted(
      pollId: widget.poll.id,
      userId: _authCubit.state.user!.id,
    );
  }
}
