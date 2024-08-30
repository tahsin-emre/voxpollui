import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voxpollui/boarding/boarding_dort.dart';

class BoardinUc extends StatefulWidget {
  const BoardinUc({Key? key}) : super(key: key);

  @override
  State<BoardinUc> createState() => _BoardinUcState();
}

class _BoardinUcState extends State<BoardinUc> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 5, 15),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Onay Kodu',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 40,
                          fontFamily: 'Gilroy-medium',
                          height: 0,
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: Colors.blue,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, // Normal durumdaki sınır
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Focus durumu için siyah sınır
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Enabled durumu için siyah sınır
                              ),
                            ),
                            counterText: '',
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                index < _controllers.length - 1) {
                              // Karakter eklendiğinde bir sonraki TextField'e geçiş yap
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index + 1]);
                            } else if (value.isEmpty && index > 0) {
                              // Karakter silindiğinde bir önceki TextField'e geçiş yap
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index - 1]);
                            }
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction
                              .next, // Klavyede sonraki tuşuna basmak için
                        ),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text.rich(
                      style: TextStyle(
                        fontSize: 11,
                      ),
                      TextSpan(
                        text:
                            ' Lütfen cep telefonunuza gelen 4 haneli kodu girin. Eğer SMS gelmediyse tekrar göndermek için',
                        style: TextStyle(
                            fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: ' buraya',
                            style: TextStyle(
                                color: Color(0xFF0C0C0C),
                                fontFamily: 'Gilroy-medium',
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' tıklayın',
                            style: TextStyle(
                                color: Color(0xFF0C0C0C),
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BoardinDort()));
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
          ),
        ],
      ),
    );
  }
}
