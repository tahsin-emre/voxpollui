import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_appbar.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  final List<Map<String, dynamic>> notifications = [
    // Burada bildirimlerinizin bir listesini oluşturun.
    // Örneğin:
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content':
          'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    // Diğer bildirimler...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.customAppBar(context, "Bildirimler"),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification['title']),
            subtitle: Text(notification['content']),
            trailing: Text(notification['time']),
          );
        },
      ),
    );
  }
}
