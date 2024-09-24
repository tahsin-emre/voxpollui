import 'package:flutter/material.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(
            'assets/image/bottom_navigation/home_png.png',
            'assets/image/bottom_navigation/home_selected_png.png',
            0,
          ),
          _buildNavBarItem(
            'assets/image/bottom_navigation/community.svg',
            'assets/image/bottom_navigation/community_selected.svg',
            1,
          ),
          _buildAddButton(),
          _buildNavBarItem(
            'assets/image/bottom_navigation/groups.svg',
            'assets/image/bottom_navigation/group_selected.svg',
            3,
          ),
          _buildNavBarItem(
            'assets/image/bottom_navigation/person_png.png',
            'assets/image/bottom_navigation/person_selected_png.png',
            4,
          ),
        ],
      ),
    );
  }
}
