import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/user.dart';
import 'package:voxpollui/pages/SurveyPage.dart';
import 'package:voxpollui/script/database.dart';
class ForWidget {
  static Widget buildCard(BuildContext context, List<Map<String, dynamic>> users, List<Map<String, dynamic>> polls, int index) {

  Database database = Database();
  print(polls[index]['createdBy']);
  return FutureBuilder(
    future: database.fetchCreater(polls[index]['createdBy']),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return const Text('Başlatılmadı');
        case ConnectionState.waiting:
          return const CircularProgressIndicator();
        case ConnectionState.active:
        case ConnectionState.done:
          if (snapshot.hasError) {
            print("${snapshot.error}");
            return Text('Hata23: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final creator = snapshot.data!;
            return Card(
              color: Colors.white,
              elevation: 0.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(  
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/login.png'),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              creator.username ?? 'Hata',
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text('${creator.followers.length ?? 'Hata'} Takipçi'),//DÜZELTİLECEK
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      polls[index]['title'] ?? 'Hata', // Anket başlığını al
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text('${polls[index]['totalParticipants'] ?? 'Hata'} Kişi Katıldı'), //DÜZELTİLECEK
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SurveyPage(pollData: polls, index: index, userData: users,)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2355FF), // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0), // Button border radius
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0), // Button padding
                        minimumSize: const Size(double.infinity, 0), // Butonun en az yükseklik değeri (0 olmalı)
                      ),
                      child: const Text(
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
          } else {
            return Text('Veri yok');
          }
        }
      }
    );
  }
}