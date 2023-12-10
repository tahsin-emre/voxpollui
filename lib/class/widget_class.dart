import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/SurveyPage.dart';
import 'package:voxpollui/script/database.dart';
class ForWidget {
  static Widget buildCard(List<Map<String, dynamic>> poll, int i) {
  Map<String, dynamic> data = poll[i];
  ParseObject? creator = data['creator'];
  ParseObject? pollData = data['poll'];

  return FutureBuilder<int>(
    future: Database.fetchPollResponseCount(pollData!['objectId']),
    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Veri henüz yüklenmediğinde ne yapılacağını burada tanımlayabilirsiniz.
        return Card(
          color: Colors.white,
          elevation: 0.0,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: CircularProgressIndicator(color: Color(0xFF2355FF),), // Bekleme göstergesi
        );
      } else if (snapshot.hasError) {
        // Hata oluştuğunda ne yapılacağını burada tanımlayabilirsiniz.
        return Card(
          color: Colors.white,
          elevation: 0.0,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Text('Hata: ${snapshot.error}'),
        );
      } else {
        // Veri başarıyla yüklendiğinde ne yapılacağını burada tanımlayabilirsiniz.
        int joinPollUsers = snapshot.data ?? 0;

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
                        Text('${data['creator'].get<dynamic>('followed').length ?? 100} Takipçi'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  pollDataBaslik, // Anket başlığını al
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text('$joinPollUsers Kişi Katıldı'),
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
    },
  );
} 
}