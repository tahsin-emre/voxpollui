import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:voxpollui/boarding/boarding_dort.dart';
import 'package:voxpollui/boarding/kvkk.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class BoardinIki extends StatefulWidget {
  const BoardinIki({super.key});

  @override
  State<BoardinIki> createState() => _BoardinIkiState();
}

class _BoardinIkiState extends State<BoardinIki> {
  bool onayliyorum = false;
  bool emailAlmak = false;
  final TextEditingController tel = TextEditingController(text: '+90 ');
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && tel.text.isEmpty) {
        tel.text = '+90 ';
        tel.selection = TextSelection.fromPosition(
          TextPosition(offset: tel.text.length),
        );
      }
    });
    tel.addListener(() {
      final text = tel.text;
      if (!text.startsWith('+90 ')) {
        tel.text = '+90 ${text.replaceAll('+90 ', '')}';
        tel.selection = TextSelection.fromPosition(
          TextPosition(offset: tel.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    tel.dispose();
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return const Color.fromARGB(255, 35, 86, 255);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
      width: 428,
      height: 926,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 41,
            top: 283,
            child: Text(
              'Telefon \n Numaranız',
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 40,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 35,
            top: 418,
            child: Container(
              width: 332,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 2.0)), // Siyah bir alt çizgi ekler
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(14), // "+90 " için 4 ekstra karakter ekleyin
                  ],
                  keyboardType: TextInputType.phone,
                  controller: tel,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    hintText: '553 772 30 30',
                    prefixText: '', // 05302300592 Burada prefixText kullanmaya gerek yok, çünkü TextEditingController zaten işimizi görüyor
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                  cursorColor: AppColor.nationalColor,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 487,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CheckboxListTile(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                title: const Text(
                  'Aydınlatma Metni’ni okudum, Açık Rıza Metni’ni okudum ve onaylıyorum.',
                  style: TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 13,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                value: onayliyorum,
                onChanged: (bool? value) {
                  setState(() {
                    onayliyorum = value ??
                        false; // onChanged tetiklendiğinde checkbox'u güncelle
                  });
                },
                controlAffinity: ListTileControlAffinity
                    .leading, // Checkbox'ı metnin sol tarafına yerleştirir
                visualDensity: const VisualDensity(
                    vertical: -4, horizontal: -4), // Border'ı kaldırır
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 540,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CheckboxListTile(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                title: const Text(
                  'Açık Rıza Metni ve Ticari Elektronik İleti Aydınlatma Metni kapsamında SMS, e-posta ve arama almak istiyorum.',
                  style: TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 13,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                value: emailAlmak,
                onChanged: (bool? value) {
                  setState(() {
                    emailAlmak = value ??
                        false; // onChanged tetiklendiğinde checkbox'u güncelle
                  });
                },
                controlAffinity: ListTileControlAffinity
                    .leading, // Checkbox'ı metnin sol tarafına yerleştirir
                visualDensity: const VisualDensity(
                    vertical: -4, horizontal: -4), // Border'ı kaldırır
              ),
            ),
          ),
          Positioned(
            left: 35,
            top: 750,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Kvkk()));
              },
              child: const SizedBox(
                width: 333,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'İleri butonuna basarak ',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: 'Kullanıcı Sözleşmesi',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '’ni kabul etmiş olursunuz.',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 101,
            top: 56,
            child: Container(
              width: 227,
              height: 227,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/login.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                if (onayliyorum && emailAlmak) {
                  // Rıza metinlerini onayladı ve e-posta almak istiyor
                  if (tel.text.isNotEmpty && tel.text.length == 14) {
                    // TextField dolu ve 10 karakter
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const BoardinDort()));
                  } else {
                    // TextField boş veya 10 karakterden farklı
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Hata'),
                          content: const Text(
                              'Lütfen telefon numaranızı 0 olmadan giriniz.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // Butona tıklandığında dialog kapatılır
                              },
                              child: const Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Rıza metinlerini onaylamadı veya e-posta almak istemiyor
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Hata'),
                        content: const Text('Rıza metinlerini kabul edilmelidir.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // Butona tıklandığında dialog kapatılır
                            },
                            child: const Text('Tamam'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
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
          ),
        ],
      ),
    ));
  }
}
