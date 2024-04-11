import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/user.dart';
import 'package:voxpollui/class/widget_class.dart';
import 'package:voxpollui/notifier/theme.dart';
import 'package:voxpollui/pages/notifications_page.dart';
import 'package:voxpollui/script/database.dart';

// ignore: must_be_immutable
class Page0 extends StatefulWidget {
  List<Map<String, dynamic>>? pollObjects;
  List<Map<String, dynamic>>? usersObjects;
  Page0({super.key, required this.pollObjects, required this.usersObjects});

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  Database database = Database();
  DataManager dataManager = DataManager();

  bool showUnansweredSurveyBox = true;
  List<dynamic>? followed;
  List<dynamic>? followers;
  String username = 'Yükleniyor..';
  String surname = 'Yükleniyor..';
  String createrId = 'Yükleniyor..';

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }


  Future<void> _loadCurrentUser() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    currentUser.fetch();
    setState(() {
      username = currentUser.username!;
      surname = currentUser.get<String>('surname') ?? 'Soyad test';
      followed = currentUser.get<List<dynamic>>('followed') ?? [];
      followers = currentUser.get<List<dynamic>>('followers') ?? [];
      //userObjectId = currentUser.get<String>('objectId') ?? 'Varsayılan ID';
    }); //@
  }

  List<Offset> starPositions = [];
  final Random _random = Random();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _alignX = -1.3; // Başlangıçta sol butonun altında olacak
  void generateStarPositions() {
    starPositions.clear();
    int rowCount = 5;
    int colCount = 5;
    double containerWidth = 80.0;
    double containerHeight = 30.0;

    double intervalX = containerWidth / (colCount - 1);
    double intervalY = containerHeight / (rowCount - 1);

    for (int row = 0; row < rowCount; row++) {
      for (int col = 0; col < colCount; col++) {
        double left = col * intervalX + _random.nextDouble() * 10 - 5;
        double top = row * intervalY + _random.nextDouble() * 10 - 5;
        starPositions.add(Offset(left, top));
      }
    }
  }

  // Tema değişikliğini işlemek için bir metod tanımlayın
  void _temayiDegistir(bool isDarkMode) {
    // setState(() {
    //   // isDarkMode = !isDarkMode;
    //   _alignX = isDarkMode ? 1.3 : -1.3;
    //   generateStarPositions();
    // });
    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              accountName: Text(
                '$username $surname',
                style: const TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              accountEmail: Column(
                children: [
                  Text(
                    '@$username \n',
                    style: const TextStyle(
                      color: Color(0xFF646464),
                      fontSize: 14,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Takip Edilen ${followed?.length ?? 0}',
                        style: const TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Takipçi ${followers?.length ?? 0}',
                        style: const TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/login.png"),
              ),
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Profil',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // Profil sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'VoxPoll Pro',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF2355FF),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // VoxPoll Pro sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'İlgi Alanları',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // İlgi Alanları sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Topluluklar',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // Topluluklar sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Arkadaşlarını Davet Et',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // Topluluklar sayfasına yönlendirme
              },
            ),
            // Diğer ListTile widget'ları...
            const Divider(),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Üretici Araçları',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // Ayarlar ve Destek sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Ödemeler',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // Ayarlar ve Destek sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Ayarlar ve Destek',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // Ayarlar ve Destek sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'S.S.S',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
                  )
                ],
              ),
              onTap: () {
                // S.S.S. sayfasına yönlendirme
              },
            ),
            ListTile(
              trailing: Consumer<ThemeNotifier>(
                  builder: (context, themeNotifier, child) {
                bool isDarkMode = themeNotifier.isDarkMode;
                return GestureDetector(
                  onTap: () {
                    _temayiDegistir(isDarkMode);
                  },
                  child: Container(
                    width: 80.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: isDarkMode
                          ? const Color.fromARGB(255, 88, 7, 146)
                          : Colors.blue,
                    ),
                    child: Stack(
                      children: [
                        // Nokta şeklinde yıldızlar
                        if (isDarkMode) ...[
                          for (Offset position in starPositions)
                            Positioned(
                              left: position.dx,
                              top: position.dy,
                              child: Container(
                                width: 2.0,
                                height: 2.0,
                                color: Colors.white, // Nokta rengi
                              ),
                            ),
                        ] else
                          for (int i = 0; i < 5; i++)
                            for (int j = 0; j < 5; j++)
                              Positioned(
                                left: j * 40.0,
                                top: i * 40.0,
                                child: const Icon(
                                  Icons.cloud,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                        AnimatedAlign(
                          alignment: Alignment(_alignX, 0),
                          duration: const Duration(milliseconds: 200),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode ? Colors.black : Colors.white,
                            ),
                            child: Icon(
                              isDarkMode
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny_rounded,
                              color: isDarkMode ? Colors.blue : Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              onTap: () {
                // S.S.S. sayfasına yönlendirme
              },
            ),
            // Alt kısımdaki butonlar için Spacer ve Row widget'ları kullanılabilir
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Text(
                      'Hoş Geldiniz',
                      style: TextStyle(
                          fontSize: 24.0, 
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 0.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$username $surname',
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${followed?.length ?? 0}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationsPage()),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState!
                                .openEndDrawer(); // openEndDrawer'ı çağırın
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/login.png'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              SliverAppBar(
                pinned: true,
                floating: true,
                toolbarHeight: 0.0,
                expandedHeight: showUnansweredSurveyBox ? 126.0 : 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: showUnansweredSurveyBox
                      ? Container(
                          padding: const EdgeInsets.all(16.0),
                          width: 1000,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Color(0xff2355ff),
                                Color(0xff001866),
                                Color(0xff153cc1),
                              ],
                              stops: [0.0, 1.0, 1.0],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '14',
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: 'Cevaplanmamış Anketiniz Var.',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              ElevatedButton(
                                onPressed: () {
                                  //Anketleri görüntüle butonu
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          width: 2, color: Colors.white),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Anketleri Görüntüle',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 10.0),
                    const Text(
                      'Takip Ettiklerim',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (dataManager.getPolls()?.isEmpty ?? true) {
                      // Eğer polls null veya boş ise, yükleme göstergesi veya mesaj göster
                      return Column(children: [
                        LoadingScreen.loadingScreen(),
                        Text(DateTime.now().toString()),
                      ]
                          //   color: Color(0xFF2355FF),
                          //   semanticsLabel: "$now",
                          //   semanticsValue: "$now",
                          // )
                          );
                    }
                    return ForWidget.buildCard(
                        context, widget.usersObjects!, widget.pollObjects!, index);
                  },
                  childCount: (dataManager.getPolls()?.isNotEmpty ?? false)
                      ? dataManager.getPolls()?.length
                      : 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}