import 'package:flutter/material.dart';
import 'package:voxpollui/pages/SurveyPage.dart';
class ForWidget {
  static Widget buildCard(BuildContext context, List<Map<String, dynamic>> creator, List<Map<String, dynamic>> poll, int index) {

  // print('BUİLDCARD creator   $creator');
  // print('BUİLDCARD poll   $poll');
   

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
                          creator[index]['username'] ?? 'Hata',
                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text('${creator[index]['followers'].length ?? 'Hata'} Takipçi'),//DÜZELTİLECEK
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  poll[index]['title'] ?? 'Hata', // Anket başlığını al
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text('${poll[index]['totalParticipants'] ?? 'Hata'} Kişi Katıldı'), //DÜZELTİLECEK
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SurveyPage(pollData: poll, index: index, userData: creator,)),
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
      }
    }