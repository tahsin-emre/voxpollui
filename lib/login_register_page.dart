import 'package:flutter/material.dart';
import 'package:voxpollui/sms_verification_page.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool agreeToTerms = false;
  bool agreeToPrivacyPolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 227,
                height: 227,
                child: Image.asset('assets/login.png'), // Replace with your image asset path
              ),
              SizedBox(height: 20.0),
              Text(
                'Telefon Numaranız',
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(height: 5.0),

              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  hintText: '+90 554 233 23 23',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0D0D0D)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (newValue) {
                      setState(() {
                        agreeToTerms = newValue ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Aydınlatma Metni’ni okudum, Açık Rıza Metni’ni okudum ve onaylıyorum.',
                      overflow: TextOverflow.visible,
                      maxLines: 2, // İstenilen satır sayısı
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: agreeToPrivacyPolicy,
                    onChanged: (newValue) {
                      setState(() {
                        agreeToPrivacyPolicy = newValue ?? false;
                      });
                    },
                  ),
                 Expanded(
                     child:  Text('Açık Rıza Metni ve Ticari Elektronik İleti Aydınlatma Metni kapsamında SMS, e-posta ve arama almak istiyorum.',
                         overflow: TextOverflow.visible,
                         maxLines: 2,
                   )),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Telefon numaranızı girerek giriş yapabilir veya kayıt olabilirsiniz.',
                style: TextStyle(fontSize: 16.0),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement login functionality
                  // After successful login, navigate to SMS verification page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SmsVerificationPage(), // Replace with your SMS verification page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2355FF), // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0), // Button border radius
                  ),
                ),
                child: Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.white, // Button text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginRegisterPage(),
  ));
}
