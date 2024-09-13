import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/features/onboarding/mixin/onboard_mixin.dart';
import 'package:voxpollui/product/localization/locale_keys.g.dart';

final class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> with OnboardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(LocaleKeys.onboard_welcome.tr()),
          ),
          ElevatedButton(
            onPressed: onContinue,
            child: Text(LocaleKeys.onboard_continue.tr()),
          ),
        ],
      ),
    );
  }
}
