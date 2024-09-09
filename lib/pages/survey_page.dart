import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
import 'package:voxpollui/class/model/user.dart';
import 'package:voxpollui/script/database.dart';

// ignore: must_be_immutable
class SurveyPage extends StatefulWidget {
  List<Map<dynamic, dynamic>> pollData;
  CreatorData userData;
  final int index;

  SurveyPage(
      {Key? key,
      required this.pollData,
      required this.index,
      required this.userData})
      : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late Future<List<PollOption>> _pollOptions;
  List<String> _pollOptionTitles = [];
  bool _hasVoted = false;
  bool isLoading = true;

  bool isPollCreator = false;
  late ParseUser currentUser;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _pollOptions = _fetchPollOptions();
    _checkIfUserVoted();
  }

  Future<void> _checkIfUserVoted() async {
    await _loadCurrentUser();
    bool hasVoted = await Database.hasUserVoted(widget.pollData, widget.index);
    setState(() {
      _hasVoted = hasVoted;
      if (!_hasVoted) {
        _pollOptions = _fetchPollOptions();
      }
      isLoading = false;
    });
  }

  Future<List<PollOption>> _fetchPollOptions() async {
    //var poll = widget.pollData[widget.index]['poll'];
    String pollId = widget.pollData[widget.index]['objectId'];
    QueryBuilder<ParseObject> queryPollOptions =
        QueryBuilder<ParseObject>(ParseObject('PollOption'))
          ..whereEqualTo('pollId', pollId);

    final ParseResponse apiResponse = await queryPollOptions.query();

    if (apiResponse.success && apiResponse.results != null) {
      _pollOptionTitles.clear();
      return apiResponse.results!.map((e) {
        String optionId = e.get<String>('objectId') ?? 'Bilinmiyor';
        String optionTitle = e.get<String>('text') ?? 'Hata';
        _pollOptionTitles.add(optionTitle);
        return PollOption(
          id: optionId,
          title: Text(optionTitle),
          votes: e.get<int>('votes') ?? 0,
        );
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> _loadCurrentUser() async {
    ParseUser? _currentUser = await ParseUser.currentUser();
    String currentUserId = _currentUser.objectId!;
    setState(() {
      currentUser = _currentUser;
      isPollCreator =
          currentUserId == widget.pollData[widget.index]['createdBy'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // DateTime? endDate = poll['createdAt'];
    bool pollEnded = false;
    late DateTime pollDate;
    if (widget.pollData[widget.index]["deletedDate"] != null) {
      String? deletedDateString = widget.pollData[widget.index]["deletedDate"];
      setState(() {
        pollDate = DateTime.parse(deletedDateString ?? '');
      });
    } else {
      setState(() {
        pollDate = DateTime(3000, 12, 12);
      });
    }

    DateTime now = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Image.asset(
            'assets/image/anket_iko.png',
            width: 100,
            height: 100,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
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
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child:
            /*isPollCreator ? const SizedBox(child: Center(child: Text("Bu Sizin Oluşturduğunuz bir anket"),),) : */
            ListView(
          children: [
            _buildCardCommunity(),
            pollDate.isBefore(now)
                ? _buildPollResults(widget.pollData, widget.userData)
                : _hasVoted
                    ? _buildPollResults(widget.pollData, widget.userData)
                    : FutureBuilder<List<PollOption>>(
                        future: _pollOptions,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingScreen.loadingScreen(text: '');
                          }

                          if (snapshot.hasError) {
                            return Text('Hata: ${snapshot.error}');
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text('Anket seçenekleri bulunamadı');
                          }
                          return Column(
                            children: [
                              // Text("${widget.pollData}"),
                              // title_image var mı yok mu kontrol edin
                              widget.pollData[widget.index]['title_image'] !=
                                      null
                                  ? Stack(
                                      children: [
                                        Image.network(
                                          widget.pollData[widget.index]
                                              ['title_image']["url"],
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          top: 8.0,
                                          right: 8.0,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.share),
                                              color: AppColor.nationalColor,
                                              onPressed: () {
                                                print("Share button clicked");
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),

                              FlutterPolls(
                                pollId: widget.pollData[widget.index]
                                    ['objectId'],
                                onVoted: (PollOption pollOption,
                                    int newTotalVotes) async {
                                  // String userId = widget.userData.objectId;
                                  String optionId = pollOption.id.toString();
                                  // print("Kullanıcı ID: $userId, Anket ID: ${widget.pollData[widget.index]['objectId']}, Seçenek ID: $optionId");
                                  ParseCloudFunction function =
                                      ParseCloudFunction('recordPollResponse');
                                  final Map<String, dynamic> params =
                                      <String, dynamic>{
                                    'userId': currentUser.objectId,
                                    'pollId': widget.pollData[widget.index]
                                        ['objectId'],
                                    'optionId': optionId
                                  };
                                  final ParseResponse result = await function
                                      .execute(parameters: params);

                                  if (result.success) {
                                    // print('Oy Başarıyla Kaydedildi');
                                    // _pollOptions'ı yeniden yüklemeyi burada yapabilirsiniz
                                    return true;
                                  } else {
                                    // print("Anket cevabı kaydedilemedi: ${result.error}");
                                    return false;
                                  }
                                },
                                pollEnded: pollEnded,
                                pollTitle: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Kalan Süre:',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GetFont.GILROY_LIGHT,
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '6 Saat 24 Dakika',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GetFont.GILROY_MEDIUM,
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.pollData[widget.index]['title'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: GetFont.GILROY_BOLD),
                                      ),
                                    ),
                                  ],
                                ),
                                pollOptions: snapshot.data!,
                                votedPercentageTextStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Anket detaylarını görüntülemek için lütfen ankete katılın.",
                style: TextStyle(fontFamily: GetFont.GILROY_MEDIUM),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardCommunity() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/image/ibrahim.png'),
      ),
      title: Row(
        children: [
          Text('${widget.userData.name}'),
          const SizedBox(width: 4.0),
          Icon(Icons.check_circle, color: AppColor.nationalColor, size: 16.0),
          const SizedBox(width: 4.0),
          Text('@${widget.userData.username}',
              style: const TextStyle(fontSize: 12.0)),
        ],
      ),
      subtitle: const Text('1.8M Takipçi'),
      trailing: InkWell(
        onTap: () {
          print("${widget.index}");
          // Burada tıklama olayını işleyin
          // // print('Trailing ikonuna tıklandı!');
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(4, pollObjects: widget.pollData, usersObjects: widget.userData,)));
        },
        child: const Icon(Icons.more_vert),
      ),
    );
  }

  Widget _buildPollResults(
      List<Map<dynamic, dynamic>> poll, CreatorData creator) {
    return FutureBuilder<List<PollOption>>(
      future: _pollOptions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return LoadingScreen.loadingScreen();
        }

        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Anket seçenekleri bulunamadı');
        }

        // List<PollOption> options = snapshot.data!;
        // int totalVotes = options.fold(0, (sum, item) => sum + item.votes);
        bool pollEnded = true;
        return FlutterPolls(
          pollId: poll[widget.index]['objectId'],
          onVoted: (PollOption pollOption, int newTotalVotes) async {
            String userId = creator.objectId;
            String optionId = pollOption.id.toString();
            print(
                "Kullanıcı ID: $userId, Anket ID: ${poll[widget.index]['objectId']}, Seçenek ID: $optionId");
            ParseCloudFunction function =
                ParseCloudFunction('recordPollResponse');
            final Map<String, dynamic> params = <String, dynamic>{
              'userId': userId,
              'pollId': poll[widget.index]['objectId'],
              'optionId': optionId
            };
            final ParseResponse result =
                await function.execute(parameters: params);

            if (result.success) {
              //print('Oy Başarıyla Kaydedildi');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Hata"),
                    content: Text(
                        "${userId + poll[widget.index]['objectid'] + optionId}"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Tamam"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Dialog'u kapat
                        },
                      ),
                    ],
                  );
                },
              );
              return true;
            } else {
              // print("Anket cevabı kaydedilemedi: ${result.error}");
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Hata"),
                    content:
                        Text("Anket cevabı kaydedilemedi: ${result.error}"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Tamam"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Dialog'u kapat
                        },
                      ),
                    ],
                  );
                },
              );
              return false;
            }
          },
          pollEnded: pollEnded,
          pollTitle: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              poll[widget.index]['title'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          pollOptions: snapshot.data!,
          votedPercentageTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}
