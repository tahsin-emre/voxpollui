import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'onboarding_page.dart';

class InterestsPage extends StatefulWidget {
  final String userId;

  InterestsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<String> selectedInterests = [];
  List<String> interestsList = [];

  @override
  void initState() {
    super.initState();
    _fetchInterests();
  }

  Future<void> _fetchInterests() async {
    final ParseResponse response = await ParseObject('Interest').getAll();
    if (response.success && response.results != null) {
      setState(() {
        interestsList = response.results!.map((e) => e.get<String>('name') as String).toList();
      });
    } else {
      // Handle error
    }
  }

  Future<void> _saveInterests() async {
    final ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    currentUser.set('interests', selectedInterests);

    final response = await currentUser.update();
    if (response.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlgi Alanları'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... [rest of the UI code remains unchanged]

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingPage()),
                );
              },//Şimdilik Eklenmiştir
              //onPressed: _saveInterests,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2355FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                minimumSize: Size(double.infinity, 0),
              ),
              child: Text(
                'İleri',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestCard(String interest) {
    bool isSelected = selectedInterests.contains(interest);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedInterests.remove(interest);
          } else if (selectedInterests.length < 10) {
            selectedInterests.add(interest);
          }
        });
      },
      child: Container(
        // ... [rest of the code remains unchanged]
      ),
    );
  }
}
