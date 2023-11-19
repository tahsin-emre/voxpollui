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

  @override
  void initState() {
    super.initState();
    _pollOptions = _fetchPollOptions();
  }

  Future<List<PollOption>> _fetchPollOptions() async {
  var pollId = widget.pollData['poll'].objectId;
  QueryBuilder<ParseObject> queryPollOptions = QueryBuilder<ParseObject>(ParseObject('PollOption'))
      ..whereEqualTo('pollId', pollId);

  final ParseResponse apiResponse = await queryPollOptions.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results!.map((e) {
      return PollOption(
        // id alanını atlıyoruz
        title: Text(e.get<String>('text') ?? 'Hata'), // 'text' alanı kullanılıyor
        votes: e.get<int>('votes') ?? 0, // 'votes' alanı kullanılıyor
      );
    }).toList();
  } else {
    // Hata durumunda boş liste döndür
    return [];
  }
}



  @override
  Widget build(BuildContext context) {
    final poll = widget.pollData['poll'];

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
                    await Future.delayed(const Duration(seconds: 1));
                    return true;
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(4)));
    },
    child: Icon(Icons.arrow_forward),
  ),
);
  }
}
