import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bildirimler'),
      ),
      body: ListView.builder(
        itemCount: 10, // Örnek amaçlı 10 bildirim
        itemBuilder: (context, index) {
          return _buildNotificationCard(index); // Bildirim kartını oluşturan fonksiyon
        },
      ),
    );
  }

  Widget _buildNotificationCard(int index) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/login.png'), // Kimden geldiği örneği
        ),
        title: Text('Bildirim Başlığı $index'), // Bildirim başlığı örneği
        subtitle: Text('Kısa açıklama $index'), // Kısa açıklama örneği
        trailing: Text('10:30'), // Saat örneği
      ),
    );
  }
}
