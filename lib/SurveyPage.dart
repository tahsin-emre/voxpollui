import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
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
  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            final Map<String, dynamic> poll = {
              'id': 1,
              'question': 'Hangi meyveyi daha çok seversiniz?',
              'options': [
                {'id': 1, 'title': 'Elma', 'votes': 5},
                {'id': 2, 'title': 'Muz', 'votes': 0},
                {'id': 3, 'title': 'Üzüm', 'votes': 0},
              ],
              'end_date': DateTime.now().add(Duration(days: 2)),
            };

            final int days = DateTime(
              poll['end_date'].year,
              poll['end_date'].month,
              poll['end_date'].day,
            ).difference(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            )).inDays;

            return Column(
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
                      var a = PollOption(
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
                      return a;
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
                    const Text(
                      '•',
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      days < 0 ? "ended" : "ends $days days",
                    ),
                  ],
                ),
              )
            )
            ]
            );
          },
        ),
      ),
    );
  }
}
