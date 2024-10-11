import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/image_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

final class RegisterOnboard extends StatefulWidget {
  const RegisterOnboard({super.key});

  @override
  State<RegisterOnboard> createState() => _RegisterOnboardState();
}

class _RegisterOnboardState extends State<RegisterOnboard> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned(
                right: (MediaQuery.of(context).size.width / 2) - 150,
                top: (MediaQuery.of(context).size.height / 2) - 25,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          ImageConstants.settings,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          ImageConstants.settingsImage,
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PageView(
                controller: pageController,
                children: const [
                  _OnboardPage(
                    image: ImageConstants.registerOnboard1,
                    title: LocaleKeys.onboard_onboard1title,
                    description: LocaleKeys.onboard_onboard1desc,
                  ),
                  _OnboardPage(
                    image: ImageConstants.registerOnboard2,
                    title: LocaleKeys.onboard_onboard2title,
                    description: LocaleKeys.onboard_onboard2desc,
                  ),
                  _OnboardPage(
                    image: ImageConstants.registerOnboard3,
                    title: LocaleKeys.onboard_onboard3title,
                    description: LocaleKeys.onboard_onboard3desc,
                  ),
                ],
              ),
            ],
          ),
        ),
        ExtendedElevatedButton(
          onPressed: () => const SplashRoute().go(context),
          text: LocaleKeys.onboard_continue.tr(),
        ),
      ],
    );
  }
}

class _OnboardPage extends StatelessWidget {
  const _OnboardPage({
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.allXL,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image),
          const Spacer(),
          Text(
            title.tr(),
            style: TextStyle(
              fontFamily: FontConstants.gilroyBold,
              fontSize: 54,
            ),
          ),
          Text(description.tr()),
          const Spacer(),
        ],
      ),
    );
  }
}
