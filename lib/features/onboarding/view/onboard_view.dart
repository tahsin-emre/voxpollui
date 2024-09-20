import 'package:flutter/material.dart';
import 'package:voxpollui/features/onboarding/mixin/onboard_mixin.dart';
import 'package:voxpollui/features/onboarding/widgets/onboard_continue.dart';
import 'package:voxpollui/features/onboarding/widgets/onboard_description.dart';
import 'package:voxpollui/features/onboarding/widgets/onboard_intro.dart';

final class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> with OnboardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          OnboardContinue(onContinue: onContinue),
          const OnboardIntro(),
          OnboardDescription(onContinue: onContinue),
        ],
      ),
    );
  }
}
