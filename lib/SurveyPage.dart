import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SurveyPage extends StatefulWidget {
  final Map<String, dynamic> pollData;

  SurveyPage({Key? key, required this.pollData}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}
class _SurveyPageState extends State<SurveyPage> {
  Widget _buildCardCommunity() {
    ParseObject? creator = widget.pollData['creator'];    // 'creator' içindeki 'username' değerini al
    String creatorUsername = creator?.get<String>('username') ?? 'Bilinmiyor';    // Bu fonksiyon topluluk kartını oluşturur.
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
      trailing: Icon(Icons.arrow_forward),
    );
  }

  // Anket verilerini oluşturur.
  Map<String, dynamic> _createPollData() {
    ParseObject? pollDataForPoll = widget.pollData['poll'];
    ParseObject? pollDataForPollOption = widget.pollData['poll'];
    String pollDataBaslik = pollDataForPoll?.get<String>('title') ?? 'Bilinmiyor';
    String pollDataOption = pollDataForPollOption?.get<String>('text') ?? 'Bilinmiyor';
    return {
      'id': 1,
      'question': '$pollDataBaslik',
      'options': [
        {'id': 1, 'title': 'Elma', 'votes': 5},
        {'id': 2, 'title': 'Muz', 'votes': 0},
        {'id': 3, 'title': 'Üzüm', 'votes': 0},
      ],
      'end_date': DateTime.now().add(Duration(days: 2)),
    };
  }

  @override
  Widget build(BuildContext context) {
    final poll = _createPollData();
    final days = DateTime(
      poll['end_date'].year,
      poll['end_date'].month,
      poll['end_date'].day,
    ).difference(DateTime.now()).inDays;

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
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: FlutterPolls(
                pollId: poll['id'].toString(),
                onVoted: (PollOption pollOption, int newTotalVotes) async {
                  await Future.delayed(const Duration(seconds: 1));
                  return true;
                },
                pollEnded: days < 0,
                pollTitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    poll['question'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                pollOptions: List<PollOption>.from(
                  poll['options'].map(
                    (option) {
                      return PollOption(
                        id: option['id'],
                        title: Text(
                          option['title'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        votes: option['votes'],
                      );
                    },
                  ),
                ),
                votedPercentageTextStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                metaWidget: Row(
                  children: [
                    const SizedBox(width: 6),
                    const Text('•'),
                    const SizedBox(width: 6),
                    Text(days < 0 ? "Anket sona erdi" : "Anket sona eriyor: $days gün"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
