import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';

class PollCreateView extends StatefulWidget {
  const PollCreateView({super.key});

  @override
  State<PollCreateView> createState() => _PollCreateViewState();
}

class _PollCreateViewState extends State<PollCreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.poll_createPoll.tr()),
      ),
      body: Center(
        child: Text(
          LocaleKeys.poll_createPoll.tr(),
        ),
      ),
    );
  }
}
