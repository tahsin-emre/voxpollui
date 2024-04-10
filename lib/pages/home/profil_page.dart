import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/script/database.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  int? i;
  // List<Map<String, dynamic>>? pollObjects;
  // List<Map<String, dynamic>>? usersObjects;
  bool isMe;
  String? viewedUser;
  
  ProfilePage(this.i, {super.key, required this.isMe, this.viewedUser});// required this.pollObjects, required this.usersObjects,

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Database database = Database();
  bool isFollowing = false;
  //bool _showUnansweredSurveyBox = true;
  dynamic followed;
  dynamic followers;
  String? objectId;
  String? username;
  String? name;
  String? surname;
  String? createrId;
  String? biyografi;
  String viewObjectId = ''; // Bu satırı ekleyin
  dynamic joinPoll;

  Map<String, dynamic>? polls;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // viewObjectId =
    //     widget.usersObjects?[widget.i ?? 0]['objectId'] ?? 'Hata';
    checkIfFollowing(
        viewObjectId); // Bu fonksiyonu çağırırken viewObjectId'i geçirin
    if (widget.isMe) {
      _loadCurrentUser();
    } else {
      _loadPollData();
    }
    //  _loadPolls();
  }

  //  void _loadPolls() async {
  //    var fetchedPolls = await database.fetchPolls();
  //    setState(() {
  //      polls = fetchedPolls;
  //    });
  //  }

  Future<void> _loadPollData() async {
    _isLoading = false;
    Database database = Database();
    ParseUser? currentUser = await ParseUser.currentUser();
    print("VİEWED USER ${widget.viewedUser}");
    final viewUsers = await database.fetchCreater(widget.viewedUser!);
    dynamic joinPoll = await Database.countUserPollResponses(
      widget.viewedUser ?? 'ObjectIDDDDDDD');
      // print('${joinPoll}    JOİN POLL');
      setState(() {
        joinPoll = joinPoll;
        objectId = currentUser.get<String>('objectId') ?? 'ObjectIDDDDDDD';
        username = viewUsers?.username;
        name = viewUsers?.name;
        surname = viewUsers?.surname;
        followed = viewUsers?.followed;
        biyografi = viewUsers?.biography;
        followers = viewUsers?.followers;
      }
    );
  }

  Future<void> _loadCurrentUser() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    dynamic joinPoll = await Database.countUserPollResponses(
        currentUser.get<String>('objectId') ?? 'ObjectIDDDDDDD');
    // print('${joinPoll}   _loadCurrentUser JOİN POLL');
    setState(() {
      joinPoll = joinPoll;
      username = currentUser.username!;
      objectId = currentUser.get<String>('objectId') ?? 'ObjectIDDDDDDD';
      name = currentUser.get<String>('name') ?? 'name test';
      surname = currentUser.get<String>('surname') ?? 'Soyad test';
      followed = currentUser.get<dynamic>('followed') ?? '0';
      biyografi = currentUser.get<String>('biography') ?? '';
      followers = currentUser.get<dynamic>('followers') ?? '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    // final data = widget.pollData ?? {
    //   'creator': {
    //     'username': username,
    //     'name': name,
    //     'surname': surname,
    //     'followed': followed,
    //     'biography': biyografi,
    //     'followers': followers,
    //   }
    // }; objectId;
    // print('$objectId   GİRİŞ YAPAN KULLANICI OBJECTID ');
    // print('$viewObjectId        GÖRÜNTÜLENEN KULLANICI OBJECTID');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            if (_isLoading)
              LoadingScreen.loadingScreen()
            else
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cover.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            // Positioned(
            //   top: 16,
            //   left: 16,
            //   child: IconButton(
            //     icon: const Icon(Icons.arrow_back, color: Colors.black),
            //     onPressed: () => Navigator.pop(context),
            //   ),
            // ),
            // Positioned(
            //   top: 16,
            //   right: 16,
            //   child: IconButton(
            //     icon: const Icon(Icons.settings, color: Colors.black),
            //     onPressed: () {},
            //   ),
            // ),
            Container(
              transform: Matrix4.translationValues(0, -50, 0),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profilepicture.png'),
              ),
            ),
            Text(
              "${name} ${surname}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('@$username'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                biyografi??'hata',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('Takip Edilen', '${followed?.length ?? 0}'),
                _buildStatColumn('Takipçi', '${followers?.length ?? 0}'),
                _buildStatColumn('Katıldığı Anket',
                    '${joinPoll ?? 'x'}'),
              ],
            ),
            const Divider(),
            TabBar(
              indicatorColor: AppColor.nationalColor,
              labelColor: AppColor.nationalColor,
              tabs: const [
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
                        // List<Map<String, dynamic>> bos = [{}];
                        // return ForWidget.buildCardCommunityWithJoinButton(
                        //     context, index, widget.pollObjects, widget.usersObjects);
                        return Container();
                      },
                    ),
                  if (polls != null)
                    ListView.builder(
                      itemCount: polls!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container();
                        // return ForWidget.buildCardCommunity(context, index, widget.pollObjects, widget.usersObjects);
                      },
                    ),
                ],
              ),
            ),
            widget.isMe == true
                ? const SizedBox.shrink()
                : Align(
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Future<void> updateFollowStatus(String currentUserObjectId,
      String viewedUserObjectId, bool isFollowing) async {
    try {
      // ParseObject olarak kullanıcıları oluştur
      var currentUser = ParseObject('_User')..objectId = currentUserObjectId;
      var viewedUser = ParseObject('_User')..objectId = viewedUserObjectId;

      // Takip edilen ve takipçiler listesini al
      List<dynamic> currentUserFollowed =
          currentUser.get<List<dynamic>>('followed') ?? [];
      List<dynamic> viewedUserFollowers =
          viewedUser.get<List<dynamic>>('followers') ?? [];

      // Takip etme veya takipten çıkma işlemini gerçekleştir
      if (isFollowing) {
        currentUserFollowed.remove(viewedUserObjectId);
        viewedUserFollowers.remove(currentUserObjectId);
      } else {
        currentUserFollowed.add(viewedUserObjectId);
        viewedUserFollowers.add(currentUserObjectId);
      }

      // Güncellenmiş listeleri set et
      currentUser.set('followed', currentUserFollowed);
      viewedUser.set('followers', viewedUserFollowers);

      // Güncellemeleri kaydet
      var responseCurrentUser = await currentUser.save();
      var responseViewedUser = await viewedUser.save();

      if (responseCurrentUser.success && responseViewedUser.success) {
        // print('Takip durumu başarıyla güncellendi');
      } else {
        // print('Takip durumu güncellenirken hata oluştu ${responseCurrentUser.error}'); //Not : Else içine giriyor ama veritabanından takip etme ve takipten çıkma işlemini gerçekleştiriyor
      }
    } catch (e) {
      // print('Bir hata oluştu: $e');
      throw Exception(e);
    }
  }

  Future<void> checkIfFollowing(String viewObjectId) async {
    // Giriş yapan kullanıcıyı al
    ParseUser? currentUser = await ParseUser.currentUser();
    // Giriş yapan kullanıcının takip ettiği kişilerin listesini al
    List<dynamic> followedUsers =
        currentUser.get<List<dynamic>>('followed') ?? [];

    // Görüntülenen kullanıcının objectId'si bu listede var mı diye kontrol et
    setState(() {
      isFollowing = followedUsers.contains(viewObjectId);
    });
    // print(
    //     '${followedUsers.contains(viewObjectId)}   Görüntülenen Takip Ediyo Mu Etmiyo Mu');
  }

  Widget _buildFollowButton(String viewObjectId) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 150),
      child: ElevatedButton(
        onPressed: () async {
          await updateFollowStatus(objectId!, viewObjectId, isFollowing);
          setState(() {
            isFollowing = !isFollowing;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing ? Colors.red : Colors.blue,
        ),
        child: Text(
          isFollowing ? 'Takibi Bırak' : 'Takip Et',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
