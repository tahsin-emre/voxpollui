import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/boarding/boarding_bir.dart';
import 'package:voxpollui/home_page.dart';

class GirisPage extends StatefulWidget {
  const GirisPage({super.key});

  @override
  State<GirisPage> createState() => _GirisPageState();
}

class _GirisPageState extends State<GirisPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<void> _loginUser() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      // Kullanıcı bilgileri eksik
      return;
    }

    final user = ParseUser(username,password,null);

    var response = await user.login();

    if (response.success) {
      // Giriş başarılı, Ana Sayfaya yönlendir
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
      );
    } else {
      // Giriş başarısız, hata mesajını göster
      throw Exception('Hata');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0,200,0,0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40,0,40,0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: 'Kullanıcı Adınızı Giriniz'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40,10,40,10),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Şifrenizi Giriniz'),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _loginUser,
                child: Text('Giriş Yap')),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => BoardinBir())));
                }, child: Text('Kayıt Ol')
              ),
            ],
          ),
        ),
      ),
    );
  }
}