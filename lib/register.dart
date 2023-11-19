import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/home_page.dart';

import 'login.dart'; // Ana sayfanızın importu

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0; // Mevcut adımı takip etmek için

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  // Diğer kişisel bilgiler için controller'lar eklenebilir

  List<String> selectedInterests = [];
  List<String> interestsList = []; // Veritabanından çekilecek ilgi alanları listesi

  @override
  void initState() {
    super.initState();
    _fetchInterests();
  }

  Future<void> _fetchInterests() async {
    final ParseResponse response = await ParseObject('Interest').getAll();
    if (response.success && response.results != null) {
      setState(() {
        // List<dynamic> türündeki değeri List<String> türüne dönüştürme
        interestsList = response.results!.map((e) => e.get<String>('name') as String).toList();
      });
    } else {
      // Hata durumunda işlem
    }
  }
// 2. Adım: Kullanıcı Seçimlerini Takip Etme
  void _toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        if (selectedInterests.length < 5) {
          selectedInterests.add(interest);
        } else {
          // Kullanıcıya en fazla 5 ilgi alanı seçebileceğini bildir
        }
      }
    });
  }

// 3. Adım: Seçimleri Veritabanına Kaydetme
  Future<void> _saveInterests() async {
    if (selectedInterests.length > 5) {
      // Hata mesajı göster
      return;
    }

    // Burada, seçilen ilgi alanlarını veritabanına kaydetme işlemini gerçekleştirin
    // Örneğin, kullanıcının ilgi alanlarını bir ParseObject olarak kaydedebilirsiniz
  }

  // Kullanıcı kaydetme fonksiyonu
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
// Kişisel bilgiler için controller'lar
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  String _gender = 'Erkek'; // Varsayılan cinsiyet
  Future<void> _registerUser() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Kişisel bilgileri ve ilgi alanlarını al
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();

    // Kişisel bilgileri al
    final birthDate = _birthDateController.text.trim();
    final city = _cityController.text.trim();
    final district = _districtController.text.trim();
    final biography = _biographyController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty || name.isEmpty || surname.isEmpty || birthDate.isEmpty || city.isEmpty || district.isEmpty || selectedInterests.isEmpty) {
      // Kullanıcı bilgileri eksik
      return;
    }
    

    final user = ParseUser.createUser(username, password, email)
      ..set('name', name)
      ..set('surname', surname)
      ..set('birthDate', birthDate)
      ..set('city', city)
      ..set('district', district)
      ..set('gender', _gender)
      ..set('interests', selectedInterests) // İlgi alanlarını kullanıcıya ekle
      ..set('biography', biography ?? '');

    var response = await user.signUp();

    if (response.success) {
      // Kayıt başarılı, oturum aç ve Ana Sayfaya yönlendir
      await ParseUser(username, password, email).login();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
      );
    } else {
      // Kayıt başarısız, hata mesajını göster
      _showErrorDialog(response.error?.message ?? 'Bir hata oluştu');
    }
  }

  void _goToNextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {
      _registerUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Giriş Yap'),
            ),
            if (currentStep == 0) ...[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: 'Kullanıcı Adı'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'E-Posta'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Şifre'),
              ),
            ],
            if (currentStep == 1) ...[
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
              TextField(
                controller: _biographyController,
                decoration: InputDecoration(hintText: 'Biyografi (isteğe bağlı)'),
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
            ],
            if (currentStep == 2) ...[
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: interestsList.map((interest) => ChoiceChip(
                  label: Text(interest),
                  selected: selectedInterests.contains(interest),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        if (selectedInterests.length < 5) {
                          selectedInterests.add(interest);
                        }
                      } else {
                        selectedInterests.remove(interest);
                      }
                    });
                  },
                )).toList(),
              ),
            ],
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _goToNextStep,
              child: Text(currentStep < 2 ? 'Devam Et' : 'Kayıt Ol ve Bitir'),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kayıt Başarısız'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
