import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voxpollui/boarding/for_pro/boarding_for_pro.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
import 'package:voxpollui/class/model/user.dart';
import 'package:voxpollui/class/widget_class.dart';
import 'package:voxpollui/notifier/theme.dart';
import 'package:voxpollui/pages/notifications_page.dart';
import 'package:voxpollui/pages/settings/ayarlar_ve_destek.dart';
import 'package:voxpollui/script/database.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

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
  String name = 'Yükleniyor..';
  String surname = 'Yükleniyor..';
  String createrId = 'Yükleniyor..';

  String titleHome = "Takip Ettikleriniz";

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
      name = currentUser.get<String>('name') ?? 'Ad test';
      surname = currentUser.get<String>('surname') ?? 'Soyad test';
      followed = currentUser.get<List<dynamic>>('followed') ?? [];
      followers = currentUser.get<List<dynamic>>('followers') ?? [];
      //userObjectId = currentUser.get<String>('objectId') ?? 'Varsayılan ID';
    }); //@
  }

  List<Offset> starPositions = [];
  final Random _random = Random();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //final double _alignX = -1.3;  Başlangıçta sol butonun altında olacak
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
    //    isDarkMode = !isDarkMode;
    //   _alignX = isDarkMode ? 1.3 : -1.3;
    //   generateStarPositions();
    // });
    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 20),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/image/ibrahim.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$name $surname",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GetFont.GILROY_BOLD,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "@$username",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 101, 101, 101),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Takip Edilen ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: GetFont.GILROY_MEDIUM,
                          ),
                        ),
                        TextSpan(
                          text: '${followed?.length ?? 158}',
                          style: TextStyle(
                              fontSize: 14, fontFamily: GetFont.GILROY_BOLD),
                        ),
                        TextSpan(
                          text: ' Takipçi ',
                          style: TextStyle(
                            fontFamily: GetFont.GILROY_MEDIUM,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: '${followers?.length ?? 0}',
                          style: TextStyle(
                            fontFamily: GetFont.GILROY_BOLD,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const Divider(height: 20),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Profil',
                  style:
                      TextStyle(fontSize: 18, fontFamily: GetFont.GILROY_BOLD),
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'VoxPoll Pro',
                  style: TextStyle(
                      color: AppColor.nationalColor,
                      fontSize: 18,
                      fontFamily: GetFont.GILROY_BOLD),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VoxpollPro(),
                  ),
                );
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'İlgi Alanları',
                  style: TextStyle(
                    fontFamily: GetFont.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                // İlgi Alanları sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Topluluklar',
                  style: TextStyle(
                    fontFamily: GetFont.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                // Topluluklar sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Arkadaşlarını Davet Et',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GetFont.GILROY_BOLD,
                  ),
                ),
              ),
              onTap: () {
                // Davet sayfasına yönlendirme
              },
            ),
            const Divider(height: 20),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Üretici Araçları',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GetFont.GILROY_BOLD,
                  ),
                ),
              ),
              onTap: () {
                // Üretici Araçları sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Ödemeler',
                  style: TextStyle(
                    fontFamily: GetFont.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                // Ödemeler sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Ayarlar ve Destek',
                  style: TextStyle(
                    fontFamily: GetFont.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AyarlarVeDestek()));
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'S.S.S',
                  style: TextStyle(
                    fontFamily: GetFont.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                // S.S.S. sayfasına yönlendirme
              },
            ),
            /*
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Çıkış Yap',
                  style: TextStyle(
                    fontFamily: GetFont.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () async {
                try {
                  ParseUser? currentUser = await ParseUser.currentUser();
                  await currentUser?.logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BoardinBir()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Çıkış yapılırken bir hata oluştu.'),
                    ),
                  );
                }
              },
            ),
            */
            const SizedBox(height: 20),
            /*
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
                },
              ),
            ),
            */
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
                    /*
                    Text(
                      'Merhaba,MerhabaMerhabaMerhabaMerhaba',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: GetFont.GILROY_LIGHT,
                      ),
                    ),
                    */
                    Row(
                      children: [
                        Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Merhaba, \n",style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: GetFont.GILROY_LIGHT,
                          )),
                          TextSpan(text: '$name $surname',style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                        ]
                      ),
                    ),
                        /*
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 200,
                              child: Text(
                                '$name $surname',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        */
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationsPage()),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/image/cal.svg',
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState!
                                .openEndDrawer(); // openEndDrawer'ı çağırın
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/image/ibrahim.png'),
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
                expandedHeight: showUnansweredSurveyBox ? 60.0 : 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: showUnansweredSurveyBox
                      ? GestureDetector(
                          onTap: () {
                            /*
                            setState(() {
                              showUnansweredSurveyBox = false;
                              titleHome = "Bekleyen Anketler";
                            });
                            */
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.nationalColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Center(
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '14 ',
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Gilroy-medium"),
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
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 10.0),
                    Text(
                      titleHome,
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Gilroy-medium"),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (dataManager.getPolls()?.isEmpty ?? true) {
                      return Column(children: [
                        LoadingScreen.loadingScreen(text: ''),
                      ]);
                    }
                    return ForWidget.buildCard(context, widget.usersObjects!,
                        widget.pollObjects!, index);
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
