import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_appbar.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'verified': true,
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Berke Kılıç',
      'handle': '@berkeklc',
      'verified': false,
      'time': '6 saat önce',
      'content':
          'Berke Kılıç seni Karen Group ekibine davet etti. Davete gitmek için buraya tıklayın.'
    },
    {
      'title': 'Anket Sonuçlandı',
      'handle': null,
      'verified': false,
      'time': '8 saat önce',
      'content':
          'Arda Güler’in Real Madrid’de forma şansı bulacağını düşünüyor musun?'
    },
    {
      'title': 'Yeni Anket Önerisi',
      'handle': null,
      'verified': false,
      'time': '2 Gün önce',
      'content':
          'Bu sezon ligi hangi takımın lider bitireceğini düşünüyorsunuz?'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'verified': true,
      'time': '3 Gün önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'verified': true,
      'time': '4 Gün önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'verified': true,
      'time': '1 Hafta önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.customAppBar(context, "Bildirimler"),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(
          color: Color.fromARGB(255, 168, 168, 168),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      notification['title'],
                      style: TextStyle(
                        fontFamily: GetFont.GILROY_BOLD,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (notification['verified'])
                      Icon(
                        Icons.verified,
                        color: AppColor.nationalColor,
                        size: 16,
                      ),
                    const SizedBox(width: 4),
                    if (notification['handle'] != null)
                      Text(
                        notification['handle'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 101, 101, 101),
                        ),
                      ),
                    const Spacer(),
                    Text(
                      notification['time'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification['content'],
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
