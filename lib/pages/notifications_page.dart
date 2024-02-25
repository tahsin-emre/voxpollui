import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    // Burada bildirimlerinizin bir listesini oluşturun.
    // Örneğin:
    {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
        {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
        {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
        {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
        {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
        {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
        {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
        {
      'title': 'Karen Group',
      'handle': '@karengroup',
      'time': '1 saat önce',
      'content': 'Karen Group yeni bir anket başlattı. Ankete katılmak için buraya tıklayın.'
    },
    // Diğer bildirimler...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bildirimler'),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(),
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
