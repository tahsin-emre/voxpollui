/*

YAPILACAK


import 'package:flutter/material.dart';

class BuildNavbarItem {
  static Widget buildNavBarItem(String iconPath, String selectedIconPath,
      int index, final Function(int) onTap) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: index == 0 || index == 4
                  ? Image.asset(
                      _currentIndex == index ? selectedIconPath : iconPath,
                      color: _currentIndex == index
                          ? const Color(0xff2355ff)
                          : Colors.grey,
                      width: 32,
                      height: 32,
                    )
                  : SvgPicture.asset(
                      _currentIndex == index ? selectedIconPath : iconPath,
                      color: _currentIndex == index
                          ? const Color(0xff2355ff)
                          : Colors.grey,
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
                      color: const Color(0xff2355ff),
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


*/