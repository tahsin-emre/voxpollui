import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/home_page.dart';

class SurveyPage extends StatefulWidget {
  final Map<String, dynamic> pollData;

  SurveyPage({Key? key, required this.pollData}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late Future<List<PollOption>> _pollOptions;
  List<String> _pollOptionTitles = []; // Bu yeni listeyi ekleyin
  bool _hasVoted = false;

  @override
  void initState() {
    super.initState();
    _pollOptions = _fetchPollOptions();
    _checkIfUserVoted();
  }

  Future<void> _checkIfUserVoted() async {
    bool hasVoted = await _hasUserVoted();
    if (hasVoted) {
      setState(() {
        _hasVoted = true;
      });
    }
  }

  Future<bool> _hasUserVoted() async {
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
  String userId = currentUser?.objectId ?? "BilinmeyenKullanıcı";
  String pollId = widget.pollData['poll'].objectId;

  QueryBuilder<ParseObject> queryUserPollResponse = QueryBuilder<ParseObject>(ParseObject('PollResponse'))
    ..whereEqualTo('userId', userId)
    ..whereEqualTo('pollId', pollId);

  final ParseResponse apiResponse = await queryUserPollResponse.query();

  if (apiResponse.success && apiResponse.results != null && apiResponse.results!.isNotEmpty) {
    // Kullanıcı bu ankette daha önce oy kullanmış
    return true;
  } else {
    // Kullanıcı bu ankette daha önce oy kullanmamış
    return false;
  }
}

  Future<List<PollOption>> _fetchPollOptions() async {
    var poll = widget.pollData['poll'];
    String pollId = poll?.get<String>('objectId') ?? 'Bilinmiyor';
    QueryBuilder<ParseObject> queryPollOptions = QueryBuilder<ParseObject>(ParseObject('PollOption'))
      ..whereEqualTo('pollId', pollId);

    final ParseResponse apiResponse = await queryPollOptions.query();

    if (apiResponse.success && apiResponse.results != null) {
      _pollOptionTitles.clear(); // Listeyi temizleyin
      return apiResponse.results!.map((e) {
        String optionId = e.get<String>('objectId') ?? 'Bilinmiyor';
        String optionTitle = e.get<String>('text') ?? 'Hata';
        _pollOptionTitles.add(optionTitle); // Başlığı listeye ekleyin
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

  @override
  Widget build(BuildContext context) {
    var poll = widget.pollData['poll'];

    DateTime? endDate = poll.get<DateTime>('endDate');
    bool pollEnded = endDate != null ? DateTime.now().isAfter(endDate) : false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Anket Sayfası'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildCardCommunity(),
            _hasVoted
                ? _buildPollResults()
                : FutureBuilder<List<PollOption>>(
                    future: _pollOptions,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Hata: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('Anket seçenekleri bulunamadı');
                      }

                      return FlutterPolls(
                        pollId: poll.objectId,
                        onVoted: (PollOption pollOption, int newTotalVotes) async {
                          ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
                          String userId = currentUser?.objectId ?? "BilinmeyenKullanıcı";
                          String optionId = pollOption.id.toString();
                          print("Kullanıcı ID: $userId, Anket ID: ${poll.objectId}, Seçenek ID: $optionId");
                          ParseCloudFunction function = ParseCloudFunction('recordPollResponse');
                          final Map<String, dynamic> params = <String, dynamic>{
                            'userId': userId,
                            'pollId': poll.objectId,
                            'optionId': optionId
                          };
                          final ParseResponse result = await function.execute(parameters: params);

                          if (result.success) {
                            print('Oy Başarıyla Kaydedildi');
                            // _pollOptions'ı yeniden yüklemeyi burada yapabilirsiniz
                            return true;
                          } else {
                            print("Anket cevabı kaydedilemedi: ${result.error}");
                            return false;
                          }
                        },
                        pollEnded: pollEnded,
                        pollTitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            poll.get<String>('title'),
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
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardCommunity() {
    ParseObject? creator = widget.pollData['creator'];
    String creatorUsername = creator?.get<String>('username') ?? 'Bilinmiyor';
    return ListTile(
  leading: CircleAvatar(
    backgroundImage: AssetImage('assets/login.png'),
  ),
  title: Row(
    children: [
      Text('$creatorUsername'),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(pollData: widget.pollData, i: 4)));
    },
    child: Icon(Icons.arrow_forward),
  ),
);
}
  Widget _buildPollResults() {
    return FutureBuilder<List<PollOption>>(
      future: _pollOptions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('Anket sonuçları bulunamadı');
        }

        List<PollOption> options = snapshot.data!;
        int totalVotes = options.fold(0, (sum, item) => sum + item.votes);

        return Column(
          children: [
            Text('Daha önce oy verdiniz. İşte sonuçlar:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                PollOption option = options[index];
                double percentage = totalVotes > 0 ? (option.votes / totalVotes) * 100 : 0;
                return ListTile(
                  title: Text(_pollOptionTitles[index]), // Burada listeyi kullanın
                  trailing: Text('${option.votes} Oy (%${percentage.toStringAsFixed(2)})'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
  import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
  import 'package:voxpollui/home_page.dart';

  class SurveyPage extends StatefulWidget {
    final Map<String, dynamic> pollData;

    SurveyPage({Key? key, required this.pollData}) : super(key: key);

    @override
    _SurveyPageState createState() => _SurveyPageState();
  }

  class _SurveyPageState extends State<SurveyPage> {
    late Future<List<PollOption>> _pollOptions;

    @override
    void initState() {
      super.initState();
      _pollOptions = _fetchPollOptions();
    }

    Future<List<PollOption>> _fetchPollOptions() async {
      var poll = widget.pollData['poll'];
      String pollId = poll?.get<String>('objectId') ?? 'Bilinmiyor';
      QueryBuilder<ParseObject> queryPollOptions = QueryBuilder<ParseObject>(ParseObject('PollOption'))
        ..whereEqualTo('pollId', pollId);

      final ParseResponse apiResponse = await queryPollOptions.query();

      if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results!.asMap().entries.map((entry) {
          int index = entry.key;
          ParseObject e = entry.value;

          return PollOption(
            id: index, // Burada 'id' int tipinde
            title: Text(e.get<String>('text') ?? 'Hata'),
            votes: e.get<int>('votes') ?? 0,
          );
        }).toList();
      } else {
        return [];
      }
    }


    @override
    Widget build(BuildContext context) {
      var poll = widget.pollData['poll'];
      DateTime? endDate = poll.get<DateTime>('endDate');
      bool pollEnded = endDate != null ? DateTime.now().isAfter(endDate) : false;

      return Scaffold(
        appBar: AppBar(
          title: Text('Anket Sayfası'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              _buildCardCommunity(),
              FutureBuilder<List<PollOption>>(
                future: _pollOptions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Anket seçenekleri bulunamadı');
                  }
                  return FlutterPolls(
                    pollId: poll.objectId,
                    onVoted: (PollOption pollOption, int newTotalVotes) async {
                      // Oturum açmış kullanıcının bilgilerini al
                      ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
                      String userId = currentUser?.objectId ?? "BilinmeyenKullanıcı";
                      // Seçilen anket seçeneğinin objectId'sini al
                      String optionId = pollOption.id.toString(); // 'id' int'ten String'e dönüştürülüyor
                      print("Kullanıcı ID: $userId, Anket ID: ${poll.objectId}, Seçenek ID: $optionId");
                      // Cloud fonksiyonunu çağır
                      ParseCloudFunction function = ParseCloudFunction('recordPollResponse');
                      final Map<String, dynamic> params = <String, dynamic>{
                        'userId': userId,
                        'pollId': poll.objectId,
                        'optionId': optionId
                      };
                      final ParseResponse result = await function.execute(parameters: params);

                      if (result.success) {
                        print('Oy Başarıyla Kaydedildi');
                        // Anket verilerini yeniden yükle
                        setState(() {
                          _pollOptions = _fetchPollOptions();
                        });
                        return true;
                      } else {
                        // Hata işleme
                        print("Anket cevabı kaydedilemedi: ${result.error}");
                        return false;
                      }
                    },

                    pollEnded: pollEnded,
                    pollTitle: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        poll.get<String>('title'),
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
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildCardCommunity() {
      ParseObject? creator = widget.pollData['creator'];
      String creatorUsername = creator?.get<String>('username') ?? 'Bilinmiyor';
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/login.png'),
        ),
        title: Row(
          children: [
            Text('$creatorUsername'),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(pollData: widget.pollData, i: 4)));
          },
          child: Icon(Icons.arrow_forward),
        ),
      );
    }
  }*/