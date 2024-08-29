import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:voxpollui/boarding/boarding_dort.dart';
import 'package:voxpollui/boarding/kvkk.dart';
import 'package:voxpollui/class/custom/custom_checkbox.dart';
import 'package:voxpollui/class/custom/custom_phone_textfield.dart';

class BoardinIki extends StatefulWidget {
  const BoardinIki({Key? key}) : super(key: key);

  @override
  State<BoardinIki> createState() => _BoardinIkiState();
}

class _BoardinIkiState extends State<BoardinIki> {
  bool onayliyorum = false;
  bool emailAlmak = false;
  final TextEditingController tel = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus && tel.text.isEmpty) {
    //     tel.text = '+90 ';
    //     tel.selection = TextSelection.fromPosition(
    //       TextPosition(offset: tel.text.length),
    //     );
    //   }
    // });
    // tel.addListener(() {
    //   final text = tel.text;
    //   if (!text.startsWith('+90 ')) {
    //     tel.text = '+90 ${text.replaceAll('+90 ', '')}';
    //     tel.selection = TextSelection.fromPosition(
    //       TextPosition(offset: tel.text.length),
    //     );
    //   }
    // });
  }

  @override
  void dispose() {
    tel.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return const Color.fromARGB(255, 35, 86, 255);
  }

  Color getColorForCheckBox(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    // return const Color.fromARGB(255, 35, 86, 255);
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(0),
            height: MediaQuery.of(context).size.height + 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Center(
                      child: Image.asset(
                    "assets/image/login.png",
                    height: 200,
                    width: 200,
                  )),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                  child: Text(
                    'Telefon\nNumaranız',
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 40,
                      fontFamily: 'Gilroy-medium',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 30, 0, 0),
                  child: Container(
                    width: 332,
                    height: 48,
                    child: PhoneTextField(
                      controller: tel,
                      focusNode: _focusNode,
                      hintText: '555 123 45 67', // Özel hint text
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomCheckbox(
                      child: const Text.rich(
                        TextSpan(
                            text: 'Aydınlatma Metni',
                            style: TextStyle(
                                color: Color(0xFF0C0C0C),
                                fontSize: 13,
                                fontFamily: 'Gilroy-medium',
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '’ni okudum,',
                                style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: 'Açık Rıza Metni',
                                style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontSize: 13,
                                    fontFamily: 'Gilroy-medium',
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '’ni okudum ve onaylıyorum.',
                                style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomCheckbox(
                      child: const Text.rich(
                        TextSpan(
                            text: 'Açık Rıza Metni ve ',
                            style: TextStyle(
                                color: Color(0xFF0C0C0C),
                                fontSize: 13,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                text:
                                    'Ticari Elektronik İleti Aydınlatma Metni ',
                                style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontFamily: 'Gilroy-medium',
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    'Kapsamında SMS, e-posta ve arama almak istiyorum.',
                                style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontSize: 13,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Column(children: [
                  GestureDetector(
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
                  GestureDetector(
                    onTap: () {
                      if (onayliyorum && emailAlmak) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BoardinDort()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Hata'),
                              content: const Text(
                                  'Rıza metinlerini kabul edilmelidir.'),
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
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
