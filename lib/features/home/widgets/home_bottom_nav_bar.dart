import 'dart:math';

import 'package:flutter/material.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/image_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({required this.onTap, required this.onAdd, super.key});
  final ValueChanged<int> onTap;
  final VoidCallback onAdd;

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.horS.add(const EdgeInsets.only(bottom: 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            image: ImageConstants.home,
            selectedImage: ImageConstants.homeSelected,
            title: LocaleKeys.feed_title,
            isSelected: _currentIndex == 0,
            onTap: () => changeIndex(0),
          ),
          _NavItem(
            image: ImageConstants.discover,
            selectedImage: ImageConstants.discoverSelected,
            title: LocaleKeys.appName,
            isSelected: _currentIndex == 1,
            onTap: () => changeIndex(1),
          ),
          _AddButton(widget.onAdd),
          _NavItem(
            image: ImageConstants.community,
            selectedImage: ImageConstants.communitySelected,
            title: LocaleKeys.appName,
            isSelected: _currentIndex == 2,
            onTap: () => changeIndex(2),
          ),
          _NavItem(
            image: ImageConstants.profile,
            selectedImage: ImageConstants.profileSelected,
            title: LocaleKeys.profile_title,
            isSelected: _currentIndex == 3,
            onTap: () => changeIndex(3),
          ),
        ],
      ),
    );
  }

  void changeIndex(int index) {
    widget.onTap(index);
    setState(() => _currentIndex = index);
  }
}

final class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.image,
    required this.selectedImage,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String image;
  final String selectedImage;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: WidgetSizes.x4L,
        height: WidgetSizes.x4L,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              child: Image.asset(
                isSelected ? selectedImage : image,
                color: isSelected ? AppColor.primary : Colors.grey,
                width: 32,
                height: 32,
              ),
            ),
            if (isSelected)
              Transform.translate(
                offset: const Offset(0, 45),
                child: Transform.rotate(
                  angle: -45 * pi / 180,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(8),
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

final class _AddButton extends StatelessWidget {
  const _AddButton(this.onAdd);
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: AppColor.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: AppColor.primary, spreadRadius: 1, blurRadius: 8),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
