import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/SurveyPage.dart';
import 'package:voxpollui/script/database.dart';
import 'createpoll.dart';
import 'notifications_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    Page0(),
    SearchPage(1), // Bu satırı değiştirin
    PlaceholderPage(2),
    CommunityPage(3),
    ProfilePage(4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
      child: Container(
        width: 36,
        height: 36,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(icon, color: _currentIndex == index ? Color(0xff2355ff) : Colors.grey, size: 32),
            ),
            if (_currentIndex == index)
              Transform.translate(
                offset: Offset(0, 45),
                child: Transform.rotate(
                  angle: -45 * (3.14159265359 / 180),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(0xff2355ff),
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
          MaterialPageRoute(builder: (context) => CreatePollPage()),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final int pageIndex;

  PlaceholderPage(this.pageIndex);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page $pageIndex'),
    );
  }
}

class Page0 extends StatefulWidget {

  @override
  _Page0State createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  bool _showUnansweredSurveyBox = true;
  int? followed;
  String username = 'Yükleniyor..';
  String surname = 'Yükleniyor..';
  String createrId = 'Yükleniyor..';

  List<Map<String, dynamic>>? polls; // Anketleri saklamak için bir liste
  Database database = Database();
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _loadPolls(); // Anketleri yüklemek için fonksiyonu çağırın
  }

    void _loadPolls() async {
    var fetchedPolls = await database.fetchPolls();
    setState(() {
      polls = fetchedPolls;
    });
  }

    Future<void> _loadCurrentUser() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      setState(() {
        username = currentUser.username!;
        surname = currentUser.get<String>('surname') ?? 'Soyad test';
        followed = currentUser.get<int>('followed') ?? 0;
        //userObjectId = currentUser.get<String>('objectId') ?? 'Varsayılan ID';
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      'Hoş Geldiniz',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 0.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$username $surname',
                              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${followed.toString()}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NotificationsPage()),
                            );
                          },
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/login.png'),
                        ),

                      ],
                    ),
                    SizedBox(height: 10.0),

                  ],
                ),
              ),
              SliverAppBar(
                pinned: true,
                floating: true,
                toolbarHeight: 0.0,
                expandedHeight: _showUnansweredSurveyBox ? 126.0 : 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: _showUnansweredSurveyBox
                      ? Container(
                    padding: EdgeInsets.all(16.0),
                    width: 1000,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
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
                          text: TextSpan(
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
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement view surveys button functionality
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(width: 2, color: Colors.white),
                              ),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Text(
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
                      : SizedBox.shrink(),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10.0),
                    Text(
                      'Takip Ettiklerim',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (polls == null) {
                    return Center(child: CircularProgressIndicator()); // Yükleme göstergesi
                  }
                  return _buildCard(polls![index]); // Anket kartını oluştur
                },
                childCount: polls?.length ?? 1, // Eğer polls null ise, yükleme göstergesi için 1 eleman göster
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> poll) {
    ParseObject? creator = poll['creator'];
    ParseObject? pollData = poll['poll'];
    if (pollData == null) {
    // pollData null ise, burada uygun bir işlem yapın
    // Örneğin, bir hata mesajı göstermek veya varsayılan bir değer kullanmak
    return SizedBox.shrink(); // Geçici bir çözüm olarak boş bir widget döndür
  }
    // 'creator' içindeki 'username' değerini al
    String creatorUsername = creator?.get<String>('username') ?? 'Bilinmiyor';
    String pollDataBaslik = pollData?.get<String>('title') ?? 'Bilinmiyor';
    return Card(
      color: Colors.white,
      elevation: 0.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/login.png'),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creatorUsername,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text('100 Takipçi'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              pollDataBaslik, // Anket başlığını al
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text('${poll['poll'].get<int>('followed') ?? 0} Kişi Katıldı'),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyPage(pollData: poll)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2355FF), // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), // Button border radius
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0), // Button padding
                minimumSize: Size(double.infinity, 0), // Butonun en az yükseklik değeri (0 olmalı)
              ),
              child: Text(
                'Katıl',
                style: TextStyle(
                  color: Colors.white, // Button text color
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class SearchPage extends StatefulWidget {
  final int pageIndex;

  SearchPage(this.pageIndex);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //bool _showUnansweredSurveyBox = true;
  String username = 'Yükleniyor..';
  String surname = 'Yükleniyor..';
  String createrId = 'Yükleniyor..';
  List<Map<String, dynamic>>? polls; // Anketleri saklamak için bir liste
  Database database = Database();
  @override
  void initState() {
    super.initState();
    _loadPolls(); // Anketleri yüklemek için fonksiyonu çağırın
  }

    void _loadPolls() async {
    var fetchedPolls = await database.fetchPolls();
    setState(() {
      polls = fetchedPolls;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // İçeriği SafeArea içerisine alın
        child: Column(
          children: [
            Container(
              height: 40.0, // Yüksekliği 40.0 piksel yapın
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8.0),
                  Text(
                    'Ara',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            // Diğer widget'larınız burada
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Keşfet',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return _buildCard(polls![index]);
                      },
                      childCount: polls?.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCard(Map<String, dynamic> poll) {
    ParseObject? creator = poll['creator'];
    ParseObject? pollData = poll['poll'];
    // 'creator' içindeki 'username' değerini al
    String creatorUsername = creator?.get<String>('username') ?? 'Bilinmiyor';
    String pollDataBaslik = pollData?.get<String>('title') ?? 'Bilinmiyor';
    return Card(
      color: Colors.white,
      elevation: 0.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/login.png'),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creatorUsername,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text('100 Takipçi'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              pollDataBaslik,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text('5 Kişi Katıldı'),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyPage()),
                );*/
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2355FF), // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), // Button border radius
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0), // Button padding
                minimumSize: Size(double.infinity, 0), // Butonun en az yükseklik değeri (0 olmalı)
              ),
              child: Text(
                'Katıl',
                style: TextStyle(
                  color: Colors.white, // Button text color
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class CommunityPage extends StatefulWidget {
  final int pageIndex;

  CommunityPage(this.pageIndex);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String username = 'Yükleniyor..';
  String surname = 'Yükleniyor..';
  String createrId = 'Yükleniyor..';
  List<Map<String, dynamic>>? polls; // Anketleri saklamak için bir liste
  Database database = Database();
  @override
  void initState() {
    super.initState();
    _loadPolls(); // Anketleri yüklemek için fonksiyonu çağırın
  }

    void _loadPolls() async {
    var fetchedPolls = await database.fetchPolls();
    setState(() {
      polls = fetchedPolls;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40.0,
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8.0),
                  Text(
                    'Ara',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Topluluklarım',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _buildCardCommunity(),
                  _buildCardCommunity(),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Önerilen Topluluklar',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _buildCardCommunityWithJoinButton(),
                  _buildCardCommunityWithJoinButton(),
                  _buildCardCommunityWithJoinButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class ProfilePage extends StatefulWidget {
  ProfilePage(int i);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/cover.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(0, -50, 0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profilepicture.png'),
              ),
            ),
            Text(
              'Profil Adı',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('@kullaniciadi'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Kısa biyografi burada yazacak.',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('Takip Edilen', 100),
                _buildStatColumn('Takipçi', 200),
                _buildStatColumn('Katıldığı Anket', 50),
              ],
            ),
            Divider(),
            TabBar(
              tabs: [
                Tab(text: 'Katıldıklarım'),
                Tab(text: 'Oluşturduklarım'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCardCommunity();
                    },
                  ),
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCardCommunity();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildStatColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

}


Widget _buildCardCommunityWithJoinButton() {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage('assets/login.png'),
    ),
    title: Row(
      children: [
        Text('Topluluk Adı'),
        SizedBox(width: 4.0),
        Icon(Icons.check_circle, color: Colors.blue, size: 16.0),
        SizedBox(width: 4.0),
        Text('@kullaniciadi', style: TextStyle(fontSize: 12.0)),
      ],
    ),
    subtitle: Text('Topluluk Açıklaması'),
    trailing: TextButton(
      onPressed: () {},
      child: Text('Katıl'),
      style: TextButton.styleFrom(
        primary: Colors.blue,
        backgroundColor: Colors.transparent,
      ),
    ),
  );
}

Widget _buildCardCommunity() {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage('assets/login.png'),
    ),
    title: Row(
      children: [
        Text('Topluluk Adı'),
        SizedBox(width: 4.0),
        Icon(Icons.check_circle, color: Colors.blue, size: 16.0),
        SizedBox(width: 4.0),
        Text('@kullaniciadi', style: TextStyle(fontSize: 12.0)),
      ],
    ),
    subtitle: Text('Topluluk Açıklaması'),
    trailing: Icon(Icons.arrow_forward),
  );
}

