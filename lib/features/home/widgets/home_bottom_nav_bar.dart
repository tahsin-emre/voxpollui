import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/image_constants.dart';

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({required this.onTap, super.key});
  final ValueChanged<int> onTap;

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(
            image: ImageConstants.home,
            selectedImage: ImageConstants.homeSelected,
            title: LocaleKeys.feed_title,
            index: 0,
          ),
          _item(
            image: ImageConstants.discover,
            selectedImage: ImageConstants.discoverSelected,
            title: LocaleKeys.appName,
            index: 1,
          ),
          _addItem(),
          _item(
            image: ImageConstants.community,
            selectedImage: ImageConstants.communitySelected,
            title: LocaleKeys.appName,
            index: 2,
          ),
          _item(
            image: ImageConstants.profile,
            selectedImage: ImageConstants.profileSelected,
            title: LocaleKeys.profile_title,
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _addItem() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: AppColor.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _item({
    required String image,
    required String selectedImage,
    required String title,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              child: Image.asset(
                _currentIndex == index ? selectedImage : image,
                color: _currentIndex == index ? AppColor.primary : Colors.grey,
                width: 32,
                height: 32,
              ),
            ),
            if (_currentIndex == index)
              Transform.translate(
                offset: const Offset(0, 45),
                child: Transform.rotate(
                  angle: -45 * (3.14159265359 / 180),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
