import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/pages/survey_page.dart';
import 'package:voxpollui/pages/home/profil_page.dart';
import 'package:voxpollui/script/database.dart';
class ForWidget {

  static Widget buildCard(BuildContext context, List<Map<String, dynamic>> users, List<Map<String, dynamic>> polls, int index) {

  Database database = Database();
  // print(polls[index]['createdBy']);
  return FutureBuilder(
    future: database.fetchCreater(polls[index]['createdBy']),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return const Text('Başlatılmadı');
        case ConnectionState.waiting:
          return LoadingScreen.loadingScreen();
        case ConnectionState.active:
        case ConnectionState.done:
          if (snapshot.hasError) {
            // print("${snapshot.error}");
            return Text('Hata23: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final creator = snapshot.data!;
            // String? deletedDateString = polls[index]["deletedDate"];
            //  if (deletedDateString != null) {
            //   DateTime pollDate = DateTime.parse(deletedDateString);
            //   DateTime now = DateTime.now();
            //   if (pollDate.isBefore(now)) {
            //     // Eğer anketin tarihi geçmişteyse, null döndürerek bu anketin gösterilmemesini sağlayın
            //     return const SizedBox.shrink();
            //   }
            // }
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
                              creator.username,
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text('${creator.followers.length} Takipçi'),//DÜZELTİLECEK
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
                          MaterialPageRoute(builder: (context) => SurveyPage(pollData: polls, index: index, userData: creator,)),
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
            return const Text('Veri yok');
          }
        }
      }
    );
  }

  static Widget buildCardCommunity(BuildContext context, int index, List<Map<String, dynamic>>? pollObjects,
  List<Map<String, dynamic>>? usersObjects) {
    //String toplulukNameOrnektir = creator != null ? creator.get<String>('name') ?? 'Bilinmiyor' : 'Bilinmiyor';

    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/login.png'),
      ),
      title: Row(
        children: [
          Text('${usersObjects![index]['name']}'),
          const SizedBox(width: 4.0),
          const Icon(Icons.check_circle, color: Colors.blue, size: 16.0),
          const SizedBox(width: 4.0),
          Text('@${usersObjects![index]['username']}',
              style: const TextStyle(fontSize: 12.0)),
        ],
      ),
      subtitle: const Text('Topluluk Açıklaması'),
      trailing: InkWell(
        onTap: () {
          print("WİDGET_CLASS ID ${usersObjects[index]['objectId']}");
          // Burada tıklama olayını işleyin
          // print('Trailing ikonuna tıklandı!');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(4, isMe: false, viewedUser: usersObjects[index]['objectId'],)));// pollObjects: pollObjects, usersObjects: usersObjects, 
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  static Widget buildCardCommunityWithJoinButton(BuildContext context, int index, List<Map<String, dynamic>>? pollObjects,
  List<Map<String, dynamic>>? usersObjects) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/login.png'),
      ),
      title: Row(
        children: [
          const Text('Topluluk Adı '),
          const SizedBox(width: 4.0),
          const Icon(Icons.check_circle, color: Colors.blue, size: 16.0),
          const SizedBox(width: 4.0),
          Text('@${usersObjects![index]['username']}',
              style: const TextStyle(fontSize: 12.0)),
        ],
      ),
      subtitle: const Text('Topluluk Açıklaması'),
      trailing: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(4, isMe: false, viewedUser: usersObjects[index]['objectId'],)));// pollObjects: pollObjects, usersObjects: usersObjects, 
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
        ),
        child: const Text('Katıl'),
      ),
    );
  }

}