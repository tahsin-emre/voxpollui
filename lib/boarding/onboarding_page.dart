import 'package:flutter/material.dart';
import 'package:voxpollui/boarding/for_pro/boarding_for_pro.dart';
import '../pages/home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> slides = [
    const OnboardingSlide(
      image: 'assets/image/onboard1.png',
      title: 'Artık Anket Zamanı',
      description:
          'İlgi alanlarınızla veya firmanızla ilgili bütün merak ettiklerinizin cevaplarını öğrenmek artık çok kolay.',
    ),
    const OnboardingSlide(
      image: 'assets/image/onboard2.png',
      title: 'İlgi Alanlarını Belirle',
      description:
          'Seçtiğiniz ilgi alanlarınıza göre anlık olarak tüm anketleri cevaplayabilir veya sonuçları inceleyebilirsiniz.',
    ),
    const OnboardingSlide(
      image: 'assets/image/onboard3.png',
      title: 'Sınırsız Ankete Katıl',
      description:
          'İstediğiniz kadar ankete katılıp dilerseniz VoxPoll Premium abonesi olup anket açıp sonuçları inceyebilirsiniz.',
    ),
    const OnboardingSlide(
      image: 'assets/image/onboard4.png',
      title: 'Merak Ettiğiniz Cevaplar',
      description:
          'Aylık 29.99₺\nİsterseniz çalışanlarınız için anket grubu oluşturun. İsterseniz merak ettiğiniz konuda bir anket açın.',
      hasButton: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return slides[index];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < slides.length; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _currentPage ? Colors.blue : Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == slides.length - 1
          ? slides[_currentPage].hasButton
              ? Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            30.0, 0.0, 0.0, 0.0), // Left margin
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const VoxpollPro(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Border radius
                                    side: const BorderSide(
                                        color: Colors.black,
                                        width: 2.0), // Border
                                  ),
                                ),
                                child: const Text('Planlar'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30.0), // Horizontal margin
                        width: double.infinity, // Full width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2355FF),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5.0), // Border radius
                            ),
                          ),
                          child: const Text(
                            'Ana Sayfa', style: TextStyle(color: Colors.white),
                            // Background color
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                )
              : const SizedBox.shrink()
          : const SizedBox.shrink(),
    );
  }
}

class OnboardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool hasButton;

  const OnboardingSlide({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.hasButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 296,
            child: Image.asset(image),
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: title
                .split(' ')
                .map((word) => Text(word,
                    style: const TextStyle(
                      fontSize: 48.0,
                      fontFamily: "Gilroy-medium",
                      fontWeight: FontWeight.w500,
                    )))
                .toList(),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 428,
            height: 926,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFF0C0C0C),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 298,
                  top: 517,
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
                              decoration: BoxDecoration(
                                color: const Color(0xFF2355FF),
                                borderRadius: BorderRadius.circular(47),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 44,
                  top: 94,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/90x90"),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 290,
                  top: 148,
                  child: Container(
                    width: 69,
                    height: 69,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/69x69"),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 149,
                  top: 281,
                  child: Container(
                    width: 125,
                    height: 125,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/125x125"),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 115,
                  top: 263,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: const BoxDecoration(
                      color: Color(0xFFED3434),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 307,
                  top: 94,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8FFF67),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 31,
                  top: 61,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF19CD),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 241,
                  top: 272,
                  child: Container(
                    width: 153,
                    height: 39,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C0C0C),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  left: 201,
                  top: 168,
                  child: Container(
                    width: 101,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C0C0C),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  left: 115,
                  top: 86,
                  child: Container(
                    width: 129,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C0C0C),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  left: 246,
                  top: 276,
                  child: Container(
                    width: 31,
                    height: 31,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF00A3D7), Color(0xFF2355FF)],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 205,
                  top: 171,
                  child: Container(
                    width: 23,
                    height: 23,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF00A3D7), Color(0xFF2355FF)],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 119,
                  top: 90,
                  child: Container(
                    width: 29,
                    height: 29,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF00A3D7), Color(0xFF2355FF)],
                      ),
                      shape: BoxShape.circle,
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
                        image:
                            NetworkImage("https://via.placeholder.com/17x17"),
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
                        image:
                            NetworkImage("https://via.placeholder.com/18x18"),
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
                        image:
                            NetworkImage("https://via.placeholder.com/11x11"),
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
                    decoration: BoxDecoration(
                      color: const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  left: 155,
                  top: 99,
                  child: Container(
                    width: 65,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  left: 236,
                  top: 177,
                  child: Container(
                    width: 38,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  left: 286,
                  top: 294,
                  child: Container(
                    width: 91,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  left: 155,
                  top: 108,
                  child: Container(
                    width: 78,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  left: 236,
                  top: 185,
                  child: Container(
                    width: 46,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const Positioned(
                  left: 47,
                  top: 520,
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
                  top: 564,
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
                  top: 608,
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
                  top: 670,
                  child: SizedBox(
                    width: 265,
                    height: 54,
                    child: Text(
                      'Merak ettiğiniz ankete katılabilir\nveya merak ettiğiniz bir anket \nbaşlatabilirsiniz.',
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
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 428,
                    height: 47,
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 33,
                          top: 14,
                          child: Container(
                            width: 54,
                            height: 21,
                            padding: const EdgeInsets.only(top: 1),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 54,
                                  height: 20,
                                  child: Text(
                                    '9:41',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF010101),
                                      fontSize: 17,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w600,
                                      height: 0.08,
                                      letterSpacing: -0.41,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 318,
                          top: 19,
                          child: SizedBox(
                            width: 77.40,
                            height: 13,
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 50,
                                  top: 0,
                                  child: SizedBox(
                                    width: 27.40,
                                    height: 13,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 26,
                                  top: 1,
                                  child: Container(
                                    width: 17,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://via.placeholder.com/17x12"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: Positioned(
                    left: 31,
                    top: 843,
                    child: Container(
                      width: 366,
                      height: 49,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2355FF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 202,
                  top: 861,
                  child: Text(
                    'İleri',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
