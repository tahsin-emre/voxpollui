import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'interestpage.dart';

class PersonalInformationPage extends StatefulWidget {
  final String userId;

  PersonalInformationPage({Key? key, required this.userId}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  String _gender = 'Erkek'; // Varsayılan cinsiyet
  Future<void> _saveDetails() async {
    final ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      // Handle the case where there is no logged-in user
      print("No current user found");
      return;
    }

    currentUser
      ..set('name', _nameController.text.trim())
      ..set('surname', _surnameController.text.trim())
      ..set('birthDate', _birthDateController.text.trim())
      ..set('city', _cityController.text.trim())
      ..set('district', _districtController.text.trim())
      ..set('gender', _gender);

    final response = await currentUser.update();

    if (response.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InterestsPage(userId: currentUser.objectId!)),
      );
    } else {
      // Show error message
      print("Failed to update user: ${response.error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kişisel Bilgiler'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Ad'),
            ),
            TextField(
              controller: _surnameController,
              decoration: InputDecoration(hintText: 'Soyad'),
            ),
            TextField(
              controller: _birthDateController,
              decoration: InputDecoration(hintText: 'Doğum Tarihi'),
            ),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(hintText: 'Şehir'),
            ),
            TextField(
              controller: _districtController,
              decoration: InputDecoration(hintText: 'İlçe'),
            ),
            DropdownButton<String>(
              value: _gender,
              onChanged: (String? newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
              items: <String>['Erkek', 'Kadın', 'Diğer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _saveDetails,
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
