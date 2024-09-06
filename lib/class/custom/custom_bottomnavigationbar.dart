/*

YAPILACAK


import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/custom_model/build_add_button.dart';
import 'package:voxpollui/class/model/custom_model/build_navbar_item.dart';

class CustomBottomnavigationbar {
  static Widget buildBottomNavigationBar(
    BuildContext context,
  ) {
    return SizedBox(
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BuildNavbarItem.buildNavBarItem(
              'assets/image/bottom_navigation/home_png.png',
              'assets/image/bottom_navigation/home_selected_png.png',
              0),
          BuildNavbarItem.buildNavBarItem(
              'assets/image/bottom_navigation/community.svg',
              'assets/image/bottom_navigation/community_selected.svg',
              1),
          BuildAddButton.buildAddButton(context),
          BuildNavbarItem.buildNavBarItem(
              'assets/image/bottom_navigation/groups.svg',
              'assets/image/bottom_navigation/group_selected.svg',
              3),
          BuildNavbarItem.buildNavBarItem(
              'assets/image/bottom_navigation/person_png.png',
              'assets/image/bottom_navigation/person_selected_png.png',
              4),
        ],
      ),
    );
  }
}


*/