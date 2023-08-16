import 'package:flutter/material.dart';

import 'onboarding_page.dart';

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  // Track selected interests
  List<String> selectedInterests = [];

  // List of available interests
  List<String> interestsList = [
    'Interest 1',
    'Interest 2',
    'Interest 3',
    'Interest 4',
    'Interest 5',
    'Interest 6',
    'Interest 7',
    'Interest 8',
    'Interest 9',
    'Interest 10',
    'Interest 11',
    'Interest 12',
    'Interest 13',
    'Interest 14',
    'Interest 15',
    'Interest 16',
    // Add more interests if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Text(
                'İlgi Alanları',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Text(
                '10 adet seçebilir ve profilinizden güncelleyebilirsiniz.',
              ),
            ),
            for (int i = 0; i < interestsList.length; i += 2)
              Row(
                children: [
                  Expanded(
                    child: _buildInterestCard(interestsList[i]),
                  ),
                  SizedBox(width: 20.0),
                  if (i + 1 < interestsList.length)
                    Expanded(
                      child: _buildInterestCard(interestsList[i + 1]),
                    ),
                  if (i + 1 >= interestsList.length)
                    Expanded(
                      child: Container(),
                    ),
                ],
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login functionality
                // After successful login, navigate to SMS verification page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OnboardingPage(), // Replace with your SMS verification page
                  ),
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
                'İleri',
                style: TextStyle(
                  color: Colors.white, // Button text color
                ),
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
          } else {
            selectedInterests.add(interest);
          }
        });
      },
      child: Container(
        height: 43,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Text(
          interest,
          style: TextStyle(
            fontSize: 16.0,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
