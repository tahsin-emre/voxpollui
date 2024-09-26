import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_state.dart';
import 'package:voxpollui/features/poll/mixin/poll_details_mixin.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/poll/option_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';

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
    return BlocBuilder<PollCubit, PollState>(
      builder: (_, state) {
        return Skeletonizer(
          enabled: state.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.poll_title.tr()),
            ),
            body: Column(
              children: [
                Image.network(widget.poll.imageUrl ?? ''),
                Text(widget.poll.title ?? ''),
                _PollOptions(options: widget.poll.options ?? []),
                Text(userVoted.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PollOptions extends StatelessWidget {
  const _PollOptions({required this.options});
  final List<OptionModel> options;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) => _PollOption(option: option)).toList(),
    );
  }
}

class _PollOption extends StatelessWidget {
  const _PollOption({required this.option});
  final OptionModel option;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(option.optionText ?? ''),
    );
  }
}
