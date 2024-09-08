import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voxpollui/boarding/for_pro/boarding_for_pro.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
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
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: slides.length,
              itemBuilder: (context, index) {
                return slides[index];
              },
            ),
            Positioned(
              right: (MediaQuery.of(context).size.width / 2) - 150,
              top: (MediaQuery.of(context).size.height / 2) - 25,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        'assets/image/setting.svg',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/image/settings_image.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < slides.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _currentPage
                            ? Colors.black
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
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
                          child: Text(
                            'İleri',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: GetFont.GILROY_BLACK),
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
                    style: TextStyle(
                      fontSize: 48.0,
                      fontFamily: GetFont.GILROY_MEDIUM,
                      fontWeight: FontWeight.bold,
                    )))
                .toList(),
          ),
          Text(
            description,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                fontFamily: GetFont.GILROY_MEDIUM),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
