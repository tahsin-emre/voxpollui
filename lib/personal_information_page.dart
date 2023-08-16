import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'interest_page.dart';

class PersonalInformationPage extends StatefulWidget {
  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  // Define controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController location2Controller = TextEditingController();
  TextEditingController genderController = TextEditingController();

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
                'Kişisel Bilgiler',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Text(
                'Bazı bilgiler sonradan değiştirilemez. Doğru girdiğinizden emin olun.',
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Ad'),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Soyad'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              controller: birthdateController,
              decoration: InputDecoration(labelText: 'Doğum Tarihi'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'İl'),
            ),
            TextField(
              controller: location2Controller,
              decoration: InputDecoration(labelText: 'İlçe'),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: 'Cinsiyet'),
            ),
            SizedBox(height: 20.0),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement login functionality
                  // After successful login, navigate to SMS verification page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InterestsPage(), // Replace with your SMS verification page
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
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.white, // Button text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
