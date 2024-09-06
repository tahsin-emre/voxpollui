import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
import 'package:voxpollui/class/model/national/get_image.dart';

class BottomSheetCustom {
  static Widget buildBottomSheetMenu(BuildContext context, String username) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading:
                Image.asset(GetImage.bottomSheetPaylas, width: 24, height: 24),
            title: Text(
              'Anketi paylaş',
              style: TextStyle(
                fontFamily: GetFont.GILROY_MEDIUM,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(height: 1),
          ),
          ListTile(
            leading: Image.asset(GetImage.bottomSheetTakipBirak,
                width: 24, height: 24),
            title: Text(
              '@$username adlı kişiyi takibi bırak',
              style: TextStyle(
                fontFamily: GetFont.GILROY_MEDIUM,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                Image.asset(GetImage.bottomSheetEngel, width: 24, height: 24),
            title: Text(
              '@$username adlı kişiyi engelle',
              style: TextStyle(
                fontFamily: GetFont.GILROY_MEDIUM,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                Image.asset(GetImage.bottomSheetSikayet, width: 24, height: 24),
            title: Text(
              '@$username adlı kişiyi şikayet et',
              style: TextStyle(
                fontFamily: GetFont.GILROY_MEDIUM,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset(GetImage.bottomSheetSessizeAl,
                width: 24, height: 24),
            title: Text(
              '@$username adlı kişiyi sessize al',
              style: TextStyle(
                fontFamily: GetFont.GILROY_MEDIUM,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(height: 1), // Divider'ı ayarladık
          ),
          ListTile(
            leading:
                Image.asset(GetImage.bottomSheetBildir, width: 24, height: 24),
            title: Text(
              'Anketi bildir',
              style: TextStyle(
                fontFamily: GetFont.GILROY_MEDIUM,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // Anket bildirme fonksiyonu buraya eklenecek
            },
          ),
        ],
      ),
    );
  }
}
