import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:voxpollui/boarding/boarding_dort.dart';
import 'package:voxpollui/boarding/kvkk.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class BoardinIki extends StatefulWidget {
  const BoardinIki({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(0),
            height: MediaQuery.of(context).size.height + 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,40,0,0),
                    child: Center(child: Image.asset(
                      "assets/image/login.png",
                      height: 200,
                      width: 200,
                    )),
                  ),
                  const Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: Text(
                      'Telefon\nNumaranız',
                      style: TextStyle(
                        color: const Color(0xFF0C0C0C),
                        fontSize: 40,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 70, 0, 0),
                    child: Container(
                      width: 332,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(14),
                          ],
                          keyboardType: TextInputType.phone,
                          controller: tel,
                          focusNode: _focusNode,
                          decoration: const InputDecoration(
                            hintText: '553 772 30 30',
                            prefixText: '',
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
                          cursorColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
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
                            onayliyorum = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
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
                            emailAlmak = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 30, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Kvkk()),
                        );
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
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (onayliyorum && emailAlmak) {
                        if (tel.text.isNotEmpty && tel.text.length == 14) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BoardinDort()),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Hata'),
                                content: const Text('Lütfen telefon numaranızı 0 olmadan giriniz.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Tamam'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Hata'),
                              content: const Text('Rıza metinlerini kabul edilmelidir.'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
        ),
        ),
      );
  }
}
