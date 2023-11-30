import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/SurveyPage.dart';
import 'package:voxpollui/script/database.dart';
import 'createpoll.dart';
import 'notifications_page.dart';
Database database = Database();
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
    ProfilePage(i: 4,),
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
                  return _buildCard(polls!, index); // Anket kartını oluştur
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

  Widget _buildCard(List<Map<String, dynamic>> poll, int i) {
    Map<String, dynamic> data = poll[i];
    ParseObject? creator = data['creator'];
    ParseObject? pollData = data['poll'];
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
                    Text('${data['poll'].get<int>('followed') ?? 100} Takipçi'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              pollDataBaslik, // Anket başlığını al
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text('${data['poll'].get<int>('followed') ?? 0} Kişi Katıldı'),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyPage(pollData: data)),
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
                      if (polls == null || polls!.isEmpty) {
                        // Eğer polls null veya boş ise, yükleme göstergesi veya mesaj göster
                        return Center(child: CircularProgressIndicator());
                      }
                      return _buildCard(polls!,index); // Anket kartını oluştur
                    },
                    childCount: (polls != null && polls!.isNotEmpty) ? polls!.length : 1,
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
  Widget _buildCard(List<Map<String, dynamic>> poll, int i) {
    Map<String, dynamic> data = poll[i];
    ParseObject? creator = data['creator'];
    ParseObject? pollData = data['poll'];

  // 'creator' ve 'pollData' objelerinin null olup olmadığını kontrol et
  String creatorUsername = creator != null ? creator.get<String>('username') ?? 'Bilinmiyor' : 'Bilinmiyor';
  String pollDataBaslik = pollData != null ? pollData.get<String>('title') ?? 'Bilinmiyor' : 'Bilinmiyor';
  int followedCount = pollData != null ? pollData.get<int>('followed') ?? 0 : 0;
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
                    Text('${followedCount ?? 100} Takipçi'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              pollDataBaslik,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text('${followedCount ?? 0} Kişi Katıldı'),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyPage(pollData: data,)),
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
              child: polls == null ? CircularProgressIndicator() : ListView(
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
              ...List.generate(polls!.length, (index) => _buildCardCommunity(context ,polls!, index)),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Önerilen Topluluklar',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
              ...List.generate(polls!.length, (index) => _buildCardCommunityWithJoinButton(context ,polls!, index)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  Map<String, dynamic>? pollData;
  ProfilePage({this.pollData, int? i});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false;
  bool _showUnansweredSurveyBox = true;
  var followed;
  var followers;
  String objectId = 'ObjectId Hatası';
  String username = 'Yükleniyor..';
  String name = 'Yükleniyor..';
  String surname = 'Yükleniyor..';
  String createrId = 'Yükleniyor..';
  String biyografi = 'Yükleniyor..';
  bool? isMe;
  String viewObjectId = ''; // Bu satırı ekleyin

  List<Map<String, dynamic>>? polls;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    viewObjectId = widget.pollData?['creator']['objectId'] ?? 'Hata';
    checkIfFollowing(viewObjectId); // Bu fonksiyonu çağırırken viewObjectId'i geçirin
    if (widget.pollData == null) {
      _loadCurrentUser();
      isMe = true;
    } else {
      _loadPollData();
      isMe = false;
    }
    _loadPolls();
  }

  void _loadPolls() async {
    var fetchedPolls = await database.fetchPolls();
    setState(() {
      polls = fetchedPolls;
      _isLoading = false;
    });
  }

  Future<void> _loadPollData() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    setState(() {
      objectId = currentUser?.get<String>('objectId') ?? 'ObjectIDDDDDDD';
      username = widget.pollData!['creator']['username'] ?? 'Yükleniyor..';
      name = widget.pollData!['creator']['name'] ?? 'Yükleniyor..';
      surname = widget.pollData!['creator']['surname'] ?? 'Yükleniyor..';
      followed = widget.pollData!['creator']['followed'] ?? '0';
      biyografi = widget.pollData!['creator']['biography'] ?? '';
      followers = widget.pollData!['creator']['followers'] ?? '0';
    });
  }

  Future<void> _loadCurrentUser() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      setState(() {
        username = currentUser.username!;
        objectId = currentUser.get<String>('objectId') ?? 'ObjectIDDDDDDD';
        name = currentUser.get<String>('name') ?? 'name test';
        surname = currentUser.get<String>('surname') ?? 'Soyad test';
        followed = currentUser.get<dynamic>('followed') ?? '0';
        biyografi = currentUser.get<String>('biography') ?? '';
        followers = currentUser.get<dynamic>('followers') ?? '0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.pollData ?? {
      'creator': {
        'username': username,
        'name': name,
        'surname': surname,
        'followed': followed,
        'biography': biyografi,
        'followers': followers,
      }
    };
    final viewObjectId = widget.pollData?['creator']['objectId'] ?? 'Hata';
    print('$objectId   GİRİŞ YAPAN KULLANICI OBJECTID ');
    print('$viewObjectId        GÖRÜNTÜLENEN KULLANICI OBJECTID');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            if (_isLoading)
              CircularProgressIndicator()
            else
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
            Container(
              transform: Matrix4.translationValues(0, -50, 0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profilepicture.png'),
              ),
            ),
            Text(
              "${data!['creator']['name'] ?? name} ${data!['creator']['surname'] ?? surname}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('@$username'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${biyografi ?? ''}',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('Takip Edilen', '${followed.length ?? 0}'),
                _buildStatColumn('Takipçi', '${followers.length ?? 0}'),
                _buildStatColumn('Katıldığı Anket', '50'), // Katıldığı anket sayısını sabit olarak veriyorum, gerektiğine göre düzeltebilirsiniz.
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
                  if (polls != null)
                    ListView.builder(
                      itemCount: polls!.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Map<String, dynamic>> bos = [{}];
                        return _buildCardCommunityWithJoinButton(
                            context, polls ?? bos, index);
                      },
                    ),
                  if (polls != null)
                    ListView.builder(
                      itemCount: polls!.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Map<String, dynamic>> bos = [{}];
                        return _buildCardCommunity(
                            context, polls ?? bos, index);
                      },
                    ),
                ],
              ),
            ),
            isMe == true ? Material() : Align(
              alignment: Alignment.centerRight, // Sağ ortada
              child: _buildFollowButton(viewObjectId),
            ),
          ],
        ),
      ),
    );
  }

  

  Column _buildStatColumn(String label, dynamic number) {
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
  Future<void> updateFollowStatus(String currentUserObjectId, String viewedUserObjectId, bool isFollowing) async {
  try {
    // ParseObject olarak kullanıcıları oluştur
    var currentUser = ParseObject('_User')..objectId = currentUserObjectId;
    var viewedUser = ParseObject('_User')..objectId = viewedUserObjectId;

    // Takip edilen ve takipçiler listesini al
    List<dynamic> currentUserFollowed = currentUser.get<List<dynamic>>('followed') ?? [];
    List<dynamic> viewedUserFollowers = viewedUser.get<List<dynamic>>('followers') ?? [];

    // Takip etme veya takipten çıkma işlemini gerçekleştir
    if (isFollowing) {
      currentUserFollowed.add(viewedUserObjectId);
      viewedUserFollowers.add(currentUserObjectId);
    } else {
      currentUserFollowed.remove(viewedUserObjectId);
      viewedUserFollowers.remove(currentUserObjectId);
    }

    // Güncellenmiş listeleri set et
    currentUser.set('followed', currentUserFollowed);
    viewedUser.set('followers', viewedUserFollowers);

    // Güncellemeleri kaydet
    var responseCurrentUser = await currentUser.save();
    var responseViewedUser = await viewedUser.save();

    if (responseCurrentUser.success && responseViewedUser.success) {
      print('Takip durumu başarıyla güncellendi');
    } else {
      print('Takip durumu güncellenirken hata oluştu');
    }
  } catch (e) {
    print('Bir hata oluştu: $e');
  }
}



Future<void> checkIfFollowing(String viewObjectId) async {
  // Giriş yapan kullanıcıyı al
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
  if (currentUser != null) {
    // Giriş yapan kullanıcının takip ettiği kişilerin listesini al
    List<dynamic> followedUsers = currentUser.get<List<dynamic>>('followed') ?? [];

    // Görüntülenen kullanıcının objectId'si bu listede var mı diye kontrol et
    setState(() {
      isFollowing = followedUsers.contains(viewObjectId);
    });
  }
}


  Widget _buildFollowButton(String viewObjectId) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 150),
      child: ElevatedButton(
        onPressed: () async {
          await updateFollowStatus(objectId, viewObjectId, isFollowing);
          setState(() {
            isFollowing = !isFollowing;
          });
        },
        child: Text(
          isFollowing ? 'Takibi Bırak' : 'Takip Et',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing ? Colors.red : Colors.blue,
        ),
      ),
    );
  }



}


Widget _buildCardCommunityWithJoinButton(BuildContext context , List<Map<String, dynamic>> poll, int i) {
  Map<String, dynamic> data = poll[i];
  ParseObject? creator = data['creator'];
  ParseObject? pollData = data['poll'];

  String creatorUsername = creator != null ? creator.get<String>('username') ?? 'Bilinmiyor' : 'Bilinmiyor';
  String pollDataBaslik = pollData != null ? pollData.get<String>('title') ?? 'Bilinmiyor' : 'Bilinmiyor';

  return ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage('assets/login.png'),
    ),
    title: Row(
      children: [
        Text('Topluluk Adı '),
        SizedBox(width: 4.0),
        Icon(Icons.check_circle, color: Colors.blue, size: 16.0),
        SizedBox(width: 4.0),
        Text('@$creatorUsername', style: TextStyle(fontSize: 12.0)),
      ],
    ),
    subtitle: Text('Topluluk Açıklaması'),
    trailing: TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(pollData: data, i: 4)));
      },
      child: Text('Katıl'),
      style: TextButton.styleFrom(
        primary: Colors.blue,
        backgroundColor: Colors.transparent,
      ),
    ),
  );
}

Widget _buildCardCommunity(BuildContext context , List<Map<String, dynamic>> poll, int i) {
  Map<String, dynamic> data = poll[i];
  ParseObject? creator = data['creator'];
  ParseObject? pollData = data['poll'];

  String creatorUsername = creator != null ? creator.get<String>('username') ?? 'Bilinmiyor' : 'Bilinmiyor';
  String pollDataBaslik = pollData != null ? pollData.get<String>('title') ?? 'Bilinmiyor' : 'Bilinmiyor';
  String toplulukNameOrnektir = creator != null ? creator.get<String>('name') ?? 'Bilinmiyor' : 'Bilinmiyor';
  //String toplulukNameOrnektir = creator != null ? creator.get<String>('name') ?? 'Bilinmiyor' : 'Bilinmiyor';


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
        Text('@$creatorUsername', style: TextStyle(fontSize: 12.0)),
      ],
    ),
    subtitle: Text('Topluluk Açıklaması'),
    trailing: InkWell(
    onTap: () {
      // Burada tıklama olayını işleyin
      print('Trailing ikonuna tıklandı!');
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(pollData: data, i: 4)));
    },
    child: Icon(Icons.arrow_forward),
  ),
  );
}

