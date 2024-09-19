import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voxpollui/product/constants/color_constants.dart';
import 'package:voxpollui/product/constants/font_constants.dart';

// ignore: must_be_immutable
class Page0 extends StatefulWidget {
  const Page0({super.key});

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                    "name surname",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontConstants.GILROY_BOLD,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "@username",
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
                            fontFamily: FontConstants.GILROY_MEDIUM,
                          ),
                        ),
                        TextSpan(
                          text: '158}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontConstants.GILROY_BOLD),
                        ),
                        TextSpan(
                          text: ' Takipçi ',
                          style: TextStyle(
                            fontFamily: FontConstants.GILROY_MEDIUM,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: '0}',
                          style: TextStyle(
                            fontFamily: FontConstants.GILROY_BOLD,
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
                  style: TextStyle(
                      fontSize: 18, fontFamily: FontConstants.GILROY_BOLD),
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
                      color: AppColor.NATIONAL_COLOR,
                      fontSize: 18,
                      fontFamily: FontConstants.GILROY_BOLD),
                ),
              ),
              onTap: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VoxpollPro(),
                  ),
                );
                */
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'İlgi Alanları',
                  style: TextStyle(
                    fontFamily: FontConstants.GILROY_BOLD,
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
                    fontFamily: FontConstants.GILROY_BOLD,
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
                    fontFamily: FontConstants.GILROY_BOLD,
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
                    fontFamily: FontConstants.GILROY_BOLD,
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
                    fontFamily: FontConstants.GILROY_BOLD,
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
                    fontFamily: FontConstants.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AyarlarVeDestek()));
              */
              },
            ),
            ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'S.S.S',
                  style: TextStyle(
                    fontFamily: FontConstants.GILROY_BOLD,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                // S.S.S. sayfasına yönlendirme
              },
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(), //CustomSwitch(),
              ),
            ),
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
                        Container(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Merhaba, \n",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: FontConstants.GILROY_LIGHT,
                                  ),
                                ),
                                TextSpan(
                                  text: 'name surname',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontFamily: FontConstants.GILROY_BOLD),
                                ),
                              ],
                            ),
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
                              /*
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationsPage()),
                              );
                              */
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
                expandedHeight: true ? 50.0 : 0.0, //showUnansweredSurveyBox
                flexibleSpace: FlexibleSpaceBar(
                  background: true //showUnansweredSurveyBox
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
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColor.NATIONAL_COLOR,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                      'titleHome',
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Gilroy-medium"),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              /*
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
              */
            ],
          ),
        ),
      ),
    );
  }
}
