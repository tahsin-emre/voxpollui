import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/boarding/onboarding_page.dart';
import 'package:intl/intl.dart';
import 'package:voxpollui/class/custom/custom_date_selector.dart';
import 'package:voxpollui/class/custom/custom_textfield.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  final TextEditingController _biographyController = TextEditingController();
  List<String> selectedInterests = [];
  List<String> interestsList = [];
  String _gender = 'Cinsiyet';
  List<String> ilList = ["İl"];
  List<String> ilIdList = [""];
  List<String> ilceList = ["İlçe"];
  String? _ilce = "İlçe";

  String _selectedIlId = "";
  String _selectedIl = "İl";

  List<String> interests = [];

  List<bool> isSelected = List.generate(18, (_) => false);
  int selectedStep = 0;

  @override
  void initState() {
    super.initState();
    _fetchInterests();
    _fetchIl();
  }

  Future<void> _fetchInterests() async {
    final ParseResponse response = await ParseObject('Interest').getAll();
    if (response.success && response.results != null) {
      setState(() {
        interestsList = response.results!
            .map((e) => e.get<String>('name') as String)
            .toList();
        interests = List<String>.from(interestsList);
        isSelected = List.generate(interests.length, (_) => false);
      });
    } else {
      // Hata durumunda işlem
    }
  }

  Future<void> _fetchIl() async {
    try {
      final ParseCloudFunction function = ParseCloudFunction('getIl');
      final ParseResponse result = await function.execute();

      if (result.success && result.result != null) {
        final responseData = result.result as List<dynamic>;
        setState(() {
          ilList = ["İl"] +
              responseData
                  .map<String>((item) => item['il_adi'] as String)
                  .toList();
          ilIdList = [""] +
              responseData
                  .map<String>((item) => item['il_id'] as String)
                  .toList();
        });
      } else {
        throw Exception('Sunucu tarafında bir hata oluştu.');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }

  Future<void> _fetchIlce() async {
    try {
      if (_selectedIlId.isEmpty) return;

      final ParseCloudFunction function = ParseCloudFunction('getIlce');
      final Map<String, dynamic> params = <String, dynamic>{
        'ilId': _selectedIlId
      };
      final ParseResponse result = await function.execute(parameters: params);

      if (result.success && result.result != null) {
        final responseData = result.result as List<dynamic>;
        setState(() {
          ilceList = ["İlçe"] +
              responseData
                  .map<String>((item) => item['ilce_adi'] as String)
                  .toList();
          _ilce = "İlçe"; // Varsayılan değeri sıfırla
        });
      } else {
        throw Exception('Sunucu tarafında bir hata oluştu.');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }

  Future<void> _registerUser() async {
    final username = _usernameController.text.trim();
    final email = _mailController.text.trim();
    String password = '123';

    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final birthDate = _birthDateController.text.trim();
    final city = _selectedIl.trim();
    final district = _ilce!.trim();
    final biography = _biographyController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        name.isEmpty ||
        surname.isEmpty ||
        birthDate.isEmpty ||
        city.isEmpty ||
        district.isEmpty ||
        city == "İl" ||
        district == "İlçe") {
      _showErrorDialog('Bir hata oluştu');
      return;
    }

    final user = ParseUser.createUser(username, password, email)
      ..set('name', name)
      ..set('surname', surname)
      ..set('birthDate', birthDate)
      ..set('city', city)
      ..set('district', district)
      ..set('gender', _gender)
      ..set('interests', selectedInterests)
      ..set('biography', biography);

    var response = await user.signUp();
    if (response.success) {
      await ParseUser(username, password, email).login();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    } else {
      _showErrorDialog(response.error?.message ?? 'Bir hata oluştu');
    }
  }

  void _goToNextStep() {
    setState(() {
      currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: currentStep == 0
              ? Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 30),
                          Text(
                            'Kişisel Bilgiler',
                            style: TextStyle(
                              color: const Color(0xFF0C0C0C),
                              fontSize: 40,
                              fontFamily: GetFont.GILROY_MEDIUM,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '*Bazı bilgiler sonradan değiştirilemez. \n Doğru girdiğinizden emin olun.',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: GetFont.GILROY_MEDIUM,
                              fontWeight: FontWeight.w100,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PollTextField.signupTextField(
                              controller: _nameController, labelText: "İsim"),
                          const SizedBox(height: 20),
                          PollTextField.signupTextField(
                              controller: _surnameController,
                              labelText: "Soyisim"),
                          const SizedBox(height: 20),
                          PollTextField.signupTextField(
                              controller: _usernameController,
                              labelText: "Kullanıcı Adı"),
                          const SizedBox(height: 20),
                          PollTextField.signupTextField(
                              controller: _mailController, labelText: "E-Mail"),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: BirthDateSelector(
                              onDateSelected: (selectedDate) {
                                if (selectedDate != null) {
                                  /*
                                  print(
                                      "Seçilen Tarih: ${selectedDate.toLocal()}");
                                      */
                                }
                              },
                              birthDateController: _birthDateController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                iconSize: 0.0,
                                value: _selectedIl,
                                onChanged: (String? newValue) {
                                  if (newValue != "İl") {
                                    setState(() {
                                      _selectedIl = newValue!;
                                      _selectedIlId =
                                          ilIdList[ilList.indexOf(_selectedIl)];
                                      _fetchIlce();
                                    });
                                  }
                                },
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                items: ilList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: value == 'İl'
                                            ? Colors.black
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                iconSize: 0.0,
                                value: _ilce,
                                onChanged: _selectedIl != "İl"
                                    ? (String? newValue) {
                                        setState(() {
                                          _ilce = newValue!;
                                        });
                                      }
                                    : null,
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                items: ilceList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: value == 'İlçe'
                                            ? Colors.black
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                iconSize: 0.0,
                                value: _gender,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _gender = newValue!;
                                  });
                                },
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                items: <String>[
                                  'Cinsiyet',
                                  'Erkek',
                                  'Kadın'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: value == 'Cinsiyet'
                                            ? Colors.black
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Spacer(),
                          GestureDetector(
                            onTap: _goToNextStep,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: double.infinity,
                              height: 49,
                              margin: const EdgeInsets.all(31),
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
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'İlgi Alanları',
                            style: TextStyle(
                              color: const Color(0xFF0C0C0C),
                              fontSize: 40,
                              fontFamily: GetFont.GILROY_MEDIUM,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '5 adet seçebilir ve profilinizden güncelleyebilirsiniz.',
                            style: TextStyle(
                              color: const Color(0xFF0C0C0C),
                              fontSize: 13,
                              fontFamily: GetFont.GILROY_MEDIUM,
                              fontWeight: FontWeight.w400,
                              height: 0.08,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  if (isSelected[index]) {
                                    // Eğer kullanıcı zaten seçili bir alana tıklarsa, seçim iptal edilsin
                                    isSelected[index] = false;
                                    selectedStep--;
                                  } else {
                                    // Eğer kullanıcı henüz seçilmemiş bir alana tıklarsa, seçim yapılsın
                                    if (selectedStep < 5) {
                                      isSelected[index] = true;
                                      selectedStep++;
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            elevation: 10,
                                            backgroundColor: Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Text(
                                                    'Dikkat',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    '5 adetten fazla ilgi alanı seçemezsiniz',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey[700],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Divider(
                                                    color: Colors.grey[300],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            AppColor
                                                                .nationalColor,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    16.0,
                                                                vertical: 10.0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.0), // Buton kenarları yuvarlatılmış
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Onayla',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .white, // Buton yazı rengi
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight
                                                              .bold, // Yazı kalınlığı
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected[index]
                                      ? const Color(0xFF2355FF)
                                      : Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[index],
                                  style: TextStyle(
                                    color: isSelected[index]
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: _registerUser,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: double.infinity,
                          height: 49,
                          margin: const EdgeInsets.all(31),
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
                ),
        );
      }),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Dikkat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Kayıt Başarısız',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Divider(
                  color: Colors.grey[300],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColor.nationalColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Buton kenarları yuvarlatılmış
                      ),
                    ),
                    child: const Text(
                      'Tamam',
                      style: TextStyle(
                        color: Colors.white, // Buton yazı rengi
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold, // Yazı kalınlığı
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
