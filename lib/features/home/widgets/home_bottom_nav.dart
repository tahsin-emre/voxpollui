import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voxpollui/product/utils/constants/image_constants.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const SizedBox(
        height: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(svgPath: ImageConstants.home),
            NavBarItem(svgPath: ImageConstants.discover),
            NavBarItem(svgPath: ImageConstants.community),
            NavBarItem(svgPath: ImageConstants.profile),
          ],
        ),
      ),
    );
  }
}

final class NavBarItem extends StatelessWidget {
  const NavBarItem({required this.svgPath, super.key});
  final String svgPath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              child: SvgPicture.asset(
                svgPath,
                color: Colors.black,
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
