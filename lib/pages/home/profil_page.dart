import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/script/database.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  int? i;
  bool isMe;
  String? viewedUser;

  ProfilePage(this.i, {super.key, required this.isMe, this.viewedUser});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Database database = Database();
  bool isFollowing = false;
  dynamic followed;
  dynamic followers;
  String? objectId;
  String? username;
  String? name;
  String? surname;
  String? biyografi = "Biyografi";
  String viewObjectId = ''; // Bu satırı ekleyin
  dynamic joinPoll;
  Map<String, dynamic>? polls;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    checkIfFollowing(viewObjectId);
    if (widget.isMe) {
      _loadCurrentUser();
    } else {
      _loadPollData();
    }
  }

  Future<void> _loadPollData() async {
    _isLoading = false;
    Database database = Database();
    ParseUser? currentUser = await ParseUser.currentUser();
    final viewUsers = await database.fetchCreater(widget.viewedUser!);
    dynamic joinPoll = await Database.countUserPollResponses(
        widget.viewedUser ?? 'ObjectIDDDDDDD');
    setState(() {
      joinPoll = joinPoll;
      objectId = currentUser.get<String>('objectId') ?? 'ObjectIDDDDDDD';
      username = viewUsers?.username;
      name = viewUsers?.name;
      surname = viewUsers?.surname;
      followed = viewUsers?.followed;
      biyografi = viewUsers?.biography;
      followers = viewUsers?.followers;
    });
  }

  Future<void> _loadCurrentUser() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    dynamic joinPoll = await Database.countUserPollResponses(
        currentUser.get<String>('objectId') ?? 'ObjectIDDDDDDD');
    setState(() {
      joinPoll = joinPoll;
      username = currentUser.username!;
      objectId = currentUser.get<String>('objectId') ?? 'ObjectIDDDDDDD';
      name = currentUser.get<String>('name') ?? 'name';
      surname = currentUser.get<String>('surname') ?? 'surname';
      followed = currentUser.get<dynamic>('followed') ?? '0';
      biyografi = currentUser.get<String>('biography') ?? 'biography';
      followers = currentUser.get<dynamic>('followers') ?? '0';

      biyografi = "Biyografi";
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                if (_isLoading)
                  LoadingScreen.loadingScreen(text: '')
                else
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/image/profile_community/backk.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Container(
                  transform: Matrix4.translationValues(0, -50, 0),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/image/profilepicture.png'),
                  ),
                ),
                Text(
                  "${name ?? "name"} ${surname ?? "surname"}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('@${username ?? "username"}'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    biyografi ?? "biyografi",
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn(
                        'Takip Edilen', '${followed?.length ?? 0}'),
                    _buildStatColumn('Takipçi', '${followers?.length ?? 0}'),
                    _buildStatColumn('Katıldığı Anket', '${joinPoll ?? 0}'),
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
                            return Container();
                          },
                        ),
                      if (polls != null)
                        ListView.builder(
                          itemCount: polls!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container();
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 188, 188, 188),
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // Ayarlar sayfasına yönlendirme
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
      var currentUser = ParseObject('_User')..objectId = currentUserObjectId;
      var viewedUser = ParseObject('_User')..objectId = viewedUserObjectId;
      List<dynamic> currentUserFollowed =
          currentUser.get<List<dynamic>>('followed') ?? [];
      List<dynamic> viewedUserFollowers =
          viewedUser.get<List<dynamic>>('followers') ?? [];
      if (isFollowing) {
        currentUserFollowed.remove(viewedUserObjectId);
        viewedUserFollowers.remove(currentUserObjectId);
      } else {
        currentUserFollowed.add(viewedUserObjectId);
        viewedUserFollowers.add(currentUserObjectId);
      }
      currentUser.set('followed', currentUserFollowed);
      viewedUser.set('followers', viewedUserFollowers);
      var responseCurrentUser = await currentUser.save();
      var responseViewedUser = await viewedUser.save();
      if (responseCurrentUser.success && responseViewedUser.success) {
        // Success
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> checkIfFollowing(String viewObjectId) async {
    ParseUser? currentUser = await ParseUser.currentUser();
    List<dynamic> followedUsers =
        currentUser.get<List<dynamic>>('followed') ?? [];
    setState(() {
      isFollowing = followedUsers.contains(viewObjectId);
    });
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
