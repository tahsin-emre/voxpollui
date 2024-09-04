import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/pages/survey_page.dart';
import 'package:voxpollui/pages/home/profil_page.dart';
import 'package:voxpollui/script/database.dart';

class ForWidget {
  static Widget buildCard(
    BuildContext context,
    List<Map<String, dynamic>> users,
    List<Map<String, dynamic>> polls,
    int index,
  ) {
    Database database = Database();
    return FutureBuilder(
      future: database.fetchCreater(polls[index]['createdBy']),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Başlatılmadı');
          case ConnectionState.waiting:
            return LoadingScreen.loadingScreen(text: '');
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Hata23: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final creator = snapshot.data!;
              return Card(
                color: Colors.white,
                elevation: 0.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            /*
                            backgroundImage:
                                NetworkImage(creator.profileImageUrl),
                                */
                            backgroundImage:
                                AssetImage("assets/image/ibrahim.png"),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      creator.name,
                                      style: const TextStyle(
                                        fontFamily: "Gilroy-medium",
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.verified,
                                      color: AppColor.nationalColor,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '@${creator.username.toLowerCase()}',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${creator.followers.length} Takipçi', // 1.8M gibi takma değer ekledim
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                print("Üç Nokta");
                              },
                              child: const Icon(Icons.more_vert)),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        polls[index]['title'] ?? 'Hata',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '${polls[index]['totalParticipants'] ?? 'Hata'} Kişi Katıldı',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SurveyPage(
                                pollData: polls,
                                index: index,
                                userData: creator,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2355FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          minimumSize: const Size(double.infinity, 0),
                        ),
                        child: const Text(
                          'Katıl',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              fontFamily: "Gilroy-medium"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Veri yok');
            }
        }
      },
    );
  }

  static Widget buildCardCommunity(
      BuildContext context,
      int index,
      List<Map<String, dynamic>>? pollObjects,
      List<Map<String, dynamic>>? usersObjects) {
    //String toplulukNameOrnektir = creator != null ? creator.get<String>('name') ?? 'Bilinmiyor' : 'Bilinmiyor';

    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/image/login.png'),
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
                  builder: (context) => ProfilePage(
                        4,
                        isMe: false,
                        viewedUser: usersObjects[index]['objectId'],
                      ))); // pollObjects: pollObjects, usersObjects: usersObjects,
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  static Widget buildCardCommunityWithJoinButton(
      BuildContext context,
      int index,
      List<Map<String, dynamic>>? pollObjects,
      List<Map<String, dynamic>>? usersObjects) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/image/login.png'),
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
                  builder: (context) => ProfilePage(
                        4,
                        isMe: false,
                        viewedUser: usersObjects[index]['objectId'],
                      ))); // pollObjects: pollObjects, usersObjects: usersObjects,
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
