import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/user.dart';
import 'package:voxpollui/class/widget_class.dart';
import 'package:voxpollui/pages/home/community_page.dart';
import 'package:voxpollui/pages/home/page0.dart';
import 'package:voxpollui/pages/home/place_holder.dart';
import 'package:voxpollui/pages/home/profil_page.dart';
import 'package:voxpollui/pages/home/search_page.dart';
import 'package:voxpollui/script/database.dart';
import 'createpoll.dart';

Database database = Database();
DataManager dataManager = DataManager();

List<Map<String, dynamic>>? pollObjects;
List<Map<String, dynamic>>? usersObjects;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Page0(),
    const SearchPage(1), // Bu satırı değiştirin
    const PlaceholderPage(2),
    const CommunityPage(3),
    ProfilePage(
      i: 4,
    ),
  ];

  @override
  void initState() {
    // TODO: SAYFALARI BÖLDÜN HEPSİNE VERİ AKTARIMI GERÇEKLEŞTİR
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(Icons.home, 0),
          _buildNavBarItem(Icons.search, 1),
          _buildAddButton(),
          _buildNavBarItem(Icons.notifications, 3),
          _buildNavBarItem(Icons.person, 4),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, int index) {
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
              alignment: Alignment.center,
              child: Icon(icon,
                  color: _currentIndex == index
                      ? const Color(0xff2355ff)
                      : Colors.grey,
                  size: 32),
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

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreatePollPage()),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xFF2355FF),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}




