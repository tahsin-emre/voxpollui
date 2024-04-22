import 'package:flutter/material.dart';
import 'package:voxpollui/boarding/boarding_iki.dart';

void main() {
  runApp(const BoardinBir());
}
class BoardinBir extends StatelessWidget {
  const BoardinBir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Stack(
        children: [
          Positioned(
            left: 298,
            top: 493,
            child: SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                children: [
                  Positioned(
                    left: 130,
                    top: 0,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(0.79),
                      child: Container(
                        width: 183.85,
                        height: 183.85,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2355FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(47),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Sağa bakan ok
                  Positioned(
                    left: 50, // Okun başlangıç noktasının x koordinatı
                    top: 115, // Okun başlangıç noktasının y koordinatı
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const BoardinIki()));
                      },
                      child: const Icon(
                          Icons.arrow_forward,
                          size: 40, // Okun boyutu
                          color: Colors.white, // Okun rengi
                        ),
                    ),
                  ),
                ],
              ),//@
            ),
          ),
          
          Positioned(
            left: 44,
            top: 94,
            child: Container(
              width: 90,
              height: 90,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/profil_foto1.png"),
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 290,
            top: 148,
            child: Container(
              width: 69,
              height: 69,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/profil_foto2.png"),
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 149,
            top: 281,
            child: Container(
              width: 125,
              height: 125,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/profil_foto3.png"),
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 115,
            top: 263,
            child: Container(
              width: 13,
              height: 13,
              decoration: const ShapeDecoration(
                color: Color(0xFFED3434),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 307,
            top: 94,
            child: Container(
              width: 18,
              height: 18,
              decoration: const ShapeDecoration(
                color: Color(0xFF8FFF67),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 31,
            top: 61,
            child: Container(
              width: 26,
              height: 26,
              decoration: const ShapeDecoration(
                color: Color(0xFFFF19CD),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 241,
            top: 272,
            child: Container(
              width: 153,
              height: 39,
              decoration: ShapeDecoration(
                color: const Color(0xFF0C0C0C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            left: 201,
            top: 168,
            child: Container(
              width: 101,
              height: 29,
              decoration: ShapeDecoration(
                color: const Color(0xFF0C0C0C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            left: 115,
            top: 86,
            child: Container(
              width: 129,
              height: 37,
              decoration: ShapeDecoration(
                color: const Color(0xFF0C0C0C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            left: 246,
            top: 276,
            child: Container(
              width: 31,
              height: 31,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF00A3D7), Color(0xFF2355FF)],
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 205,
            top: 171,
            child: Container(
              width: 23,
              height: 23,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF00A3D7), Color(0xFF2355FF)],
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 119,
            top: 90,
            child: Container(
              width: 29,
              height: 29,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF00A3D7), Color(0xFF2355FF)],
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 125,
            top: 96,
            child: Container(
              width: 17,
              height: 17,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/image/Done.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 253,
            top: 282,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/image/Done.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 211,
            top: 177,
            child: Container(
              width: 11,
              height: 11,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/image/Done.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 286,
            top: 284,
            child: Container(
              width: 76,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFF323232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 155,
            top: 99,
            child: Container(
              width: 65,
              height: 3,
              decoration: ShapeDecoration(
                color: const Color(0xFF323232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 236,
            top: 177,
            child: Container(
              width: 38,
              height: 3,
              decoration: ShapeDecoration(
                color: const Color(0xFF323232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 286,
            top: 294,
            child: Container(
              width: 91,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFF323232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 155,
            top: 108,
            child: Container(
              width: 78,
              height: 3,
              decoration: ShapeDecoration(
                color: const Color(0xFF323232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 236,
            top: 185,
            child: Container(
              width: 46,
              height: 3,
              decoration: ShapeDecoration(
                color: const Color(0xFF323232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 47,
            top: 500,
            child: Text(
              'Bütün merak',
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 40,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ),
          const Positioned(
            left: 47,
            top: 544,
            child: Text(
              'ettiğiniz',
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 40,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ),
          const Positioned(
            left: 47,
            top: 588,
            child: Text(
              'cevaplar',
              style: TextStyle(
                color: Color(0xFF2355FF),
                fontSize: 40,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          const Positioned(
            left: 47,
            top: 650,
            child: SizedBox(
              width: 265,
              height: 54,
              child: Text(
                'Merak ettiğiniz ankete katılabilir\n',
                style: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                  height: 0.07,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 47,
            top: 670,
            child: SizedBox(
              width: 265,
              height: 54,
              child: Text(
                'veya merak ettiğiniz bir anket \n',
                style: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                  height: 0.07,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 47,
            top: 690,
            child: SizedBox(
              width: 265,
              height: 54,
              child: Text(
                'başlatabilirsiniz.',
                style: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                  height: 0.07,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BoardinIki()));
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
                    borderRadius: BorderRadius.circular(10),
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
          )
        ],
      ),
    ));
  }
}
