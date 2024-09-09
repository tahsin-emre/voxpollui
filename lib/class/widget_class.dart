import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_bottom_sheet_menu.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
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
                                      style: TextStyle(
                                        fontFamily: GetFont.GILROY_MEDIUM,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
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
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: const Color.fromARGB(
                                              255, 101, 101, 101),
                                          fontFamily: GetFont.GILROY_MEDIUM,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${creator.followers.length} Takipçi',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: GetFont.GILROY_MEDIUM),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.white38,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(50)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          spreadRadius: 5,
                                          blurRadius: 15,
                                          offset: const Offset(0, -5),
                                        ),
                                      ],
                                    ),
                                    child:
                                        BottomSheetCustom.buildBottomSheetMenu(
                                            context, creator.username),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.more_vert),
                          ),
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
                        '${polls[index]['totalParticipants'] ?? 'Hata'} kişi katıldı',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: GetFont.GILROY_LIGHT),
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
                        child: Text(
                          'Katıl',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: GetFont.GILROY_BOLD),
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
    List<String> profileCommunity = [
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
    ];
    List<String> aciklamaCommunity = [
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
    ];
    return GestureDetector(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(profileCommunity[index]),
        ),
        title: Row(
          children: [
            Text('${usersObjects![index]['name']}'),
            const SizedBox(width: 4.0),
            Icon(Icons.check_circle, color: AppColor.nationalColor, size: 16.0),
            const SizedBox(width: 4.0),
            Text('@${usersObjects[index]['username']}',
                style: const TextStyle(fontSize: 12.0)),
          ],
        ),
        subtitle: Text(aciklamaCommunity[index]),
        trailing: GestureDetector(
          onTap: () {
            /*
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          4,
                          isMe: false,
                          viewedUser: usersObjects[index]['objectId'],
                        ))); // pollObjects: pollObjects, usersObjects: usersObjects,
          */
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              barrierColor: Colors.white38,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: BottomSheetCustom.buildBottomSheetMenu(
                      context, usersObjects[index]["username"]),
                );
              },
            );
          },
          child: const Icon(Icons.more_vert),
        ),
      ),
    );
  }

  static Widget buildCardCommunityWithJoinButton(
      BuildContext context,
      int index,
      List<Map<String, dynamic>>? pollObjects,
      List<Map<String, dynamic>>? usersObjects) {
    List<String> profileCommunity = [
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
      "assets/image/profile_community/1453.png",
      "assets/image/profile_community/baydoner.png",
      "assets/image/profile_community/beymen.png",
      "assets/image/profile_community/cinema.png",
      "assets/image/profile_community/gofrette_profile.png",
      "assets/image/profile_community/karen.png",
    ];
    List<String> nameCommunity = [
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
      "1453 Osmanlı",
      "Baydöner",
      "Beymen",
      "Cinemamaximum",
      "Gofrette",
      "Karen Bilişim",
    ];
    List<String> aciklamaCommunity = [
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
      "4.3M Katılımcı",
      "142 Katılımcı",
    ];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileCommunity[index]),
      ),
      title: Row(
        children: [
          Text(
            nameCommunity[index],
            style: TextStyle(fontFamily: GetFont.GILROY_BOLD),
          ),
          const SizedBox(width: 4.0),
          Icon(Icons.check_circle, color: AppColor.nationalColor, size: 16.0),
          const SizedBox(width: 4.0),
          Text('@${usersObjects![index]['username']}',
              style:
                  TextStyle(fontSize: 12.0, fontFamily: GetFont.GILROY_LIGHT)),
        ],
      ),
      subtitle: Text(
        aciklamaCommunity[index],
        style: TextStyle(fontFamily: GetFont.GILROY_MEDIUM),
      ),
      trailing: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(4,
                      isMe: false,
                      viewedUser: usersObjects[index]['objectId'],
                      pollObjects: pollObjects,
                      usersObjects: usersObjects)));
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          'Katıl',
          style: TextStyle(fontFamily: GetFont.GILROY_MEDIUM),
        ),
      ),
    );
  }
}
