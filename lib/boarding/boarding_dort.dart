import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/boarding/onboarding_page.dart';

class BoardinDort extends StatefulWidget {
  const BoardinDort({Key? key}) : super(key: key);

  @override
  State<BoardinDort> createState() => _StateBoardinDort();
}

class _StateBoardinDort extends State<BoardinDort> {
  int currentStep = 0; // Mevcut adımı takip etmek için
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  List<String> selectedInterests = [];
  List<String> interestsList =
      []; // Veritabanından çekilecek ilgi alanları listesi
  String _gender = 'Erkek'; // Varsayılan cinsiyet

  List<String> interests = [];

  List<bool> isSelected = List.generate(18, (_) => false);

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
        interestsList = response.results!
            .map((e) => e.get<String>('name') as String)
            .toList();

        // İlgi alanları listesini ilgi alanları seçimi için kullanılan
        // isSelected listesi ile eşleştir
        interests = List<String>.from(interestsList);
        isSelected = List.generate(interests.length, (_) => false);
      });
    } else {
      // Hata durumunda işlem@
    }
  }

  Future<void> _registerUser() async {
    final username = _usernameController.text.trim();
    final email = _mailController.text.trim();
    String password = '123';

    // Kişisel bilgileri ve ilgi alanlarını al
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();

    // Kişisel bilgileri al
    final birthDate = _birthDateController.text.trim();
    final city = _cityController.text.trim();
    final district = _districtController.text.trim();
    final biography = _biographyController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        name.isEmpty ||
        surname.isEmpty ||
        birthDate.isEmpty ||
        city.isEmpty ||
        district.isEmpty) {
      _showErrorDialog('h' 'Bir hata oluştu');
      return;
    }

    final user = ParseUser.createUser(username, password, email)
      ..set('name', name)
      ..set('surname', surname)
      ..set('birthDate', birthDate)
      ..set('city', city)
      ..set('district', district)
      ..set('gender', _gender)
      ..set('interests',
          selectedInterests) // İlgi alanlarını kullanıcıya ekle
      ..set('biography', biography);

    var response = await user.signUp();
//@
    if (response.success) {
      // Kayıt başarılı, oturum aç ve Ana Sayfaya yönlendir
      await ParseUser(username, password, email).login();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    } else {
      // print(response.error); // Hata mesajını yazdır
      _showErrorDialog(response.error?.message ?? 'Bir hata oluştu');
    }

  } //@

  void _goToNextStep() {
    setState(() {
      currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          // Klavye açıkken tıklanırsa klavyeyi kapat@
          FocusScope.of(context).unfocus();
        },
        child: currentStep == 0
              ? SingleChildScrollView(
                  child:  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),//@
                      const Text(
                        'Kişisel Bilgiler',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 40,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '*Bazı bilgiler sonradan değiştirilemez. Doğru girdiğinizden emin olun.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'İsim',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: _surnameController,
                        decoration: const InputDecoration(
                          labelText: 'Soyisim',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Kullanıcı Adı',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: _mailController,
                        decoration: const InputDecoration(
                          labelText: 'E-Mail',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: _birthDateController,
                        decoration: const InputDecoration(
                          labelText: 'Doğum Tarihi',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: _cityController,
                        decoration: const InputDecoration(
                          labelText: 'İl',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: _districtController,
                        decoration: const InputDecoration(
                          labelText: 'İlçe',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      DropdownButton<String>(
                        value: _gender,
                        onChanged: (String? newValue) {
                          setState(() {
                            _gender = newValue!;
                          });
                        }, //@
                        items: <String>['Erkek', 'Kadın', 'Diğer']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _goToNextStep,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: double.infinity,
                          height: 49,
                          margin: const EdgeInsets.all(
                              31), // Burası ekranın kenar boşluklarını ayarlar
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2355FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'İleri',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              )
              :Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'İlgi Alanları',
                      style: TextStyle(
                        color: Color(0xFF0C0C0C),
                        fontSize: 40,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      '5 adet seçebilir ve profilinizden güncelleyebilirsiniz.',
                      style: TextStyle(
                        color: Color(0xFF0C0C0C),
                        fontSize: 13,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400,
                        height: 0.08,
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                          itemCount: interests.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected[index] = !isSelected[index];
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected[index]
                                      ? const Color(0xFF2355FF)
                                      : Colors.white,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  interests[index],
                                  style: TextStyle(
                                      color: isSelected[index]
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            );
                          },
                        ),
                    ),
                    GestureDetector(
                      onTap: _registerUser,
                      //onTap: _registerUser,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        height: 49,
                        margin: const EdgeInsets.all(
                            31), // Burası ekranın kenar boşluklarını ayarlar
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2355FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'İleri',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      );
    }));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kayıt Başarısız'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
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
