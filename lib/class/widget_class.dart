import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/SurveyPage.dart';
import 'package:voxpollui/class/model/user.dart';
import 'package:voxpollui/script/database.dart';
class ForWidget {
  static Widget buildCard(BuildContext context, List<Map<String, dynamic>> creator, List<Map<String, dynamic>> poll, int index) {

  print('BUİLDCARD creator   $creator');
  print('BUİLDCARD poll   $poll');
   

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
                          creator[index]['username'] ?? 'Hata',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text('${creator[index]['followers'].length ?? 'Hata'} Takipçi'),//DÜZELTİLECEK
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  poll[index]['title'] ?? 'Hata', // Anket başlığını al
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text('${poll[index]['totalParticipants'] ?? 'Hata'} Kişi Katıldı'), //DÜZELTİLECEK
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SurveyPage(pollData: poll, index: index,)),
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
    }