import 'package:flutter/material.dart';
import 'package:voxpollui/personal_information_page.dart';

class SmsVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Verification'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Onay Kodu',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildVerificationBox(),
                  _buildVerificationBox(),
                  _buildVerificationBox(),
                  _buildVerificationBox(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Lütfen cep telefonunuza gelen 4 haneli kodu girin. Eğer SMS gelmediyse tekrar göndermek için buraya tıklayın.',
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement login functionality
                  // After successful login, navigate to SMS verification page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonalInformationPage(), // Replace with your SMS verification page
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

  Widget _buildVerificationBox() {
    return Container(
      width: 50,
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          counter: Offstage(),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SmsVerificationPage(),
  ));
}
