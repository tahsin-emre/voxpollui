import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'home_page.dart';
class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      image: 'assets/onboard1.png',
      title: 'Artık Anket Zamanı',
      description:
      'İlgi alanlarınızla veya firmanızla ilgili bütün merak ettiklerinizin cevaplarını öğrenmek artık çok kolay.',
    ),
    OnboardingSlide(
      image: 'assets/onboard2.png',
      title: 'İlgi Alanlarını Belirle',
      description:
      'Seçtiğiniz ilgi alanlarınıza göre anlık olarak tüm anketleri cevaplayabilir veya sonuçları inceleyebilirsiniz.',
    ),
    OnboardingSlide(
      image: 'assets/onboard3.png',
      title: 'Sınırsız Ankete Katıl',
      description:
      'İstediğiniz kadar ankete katılıp dilerseniz VoxPoll Premium abonesi olup anket açıp sonuçları inceyebilirsiniz.',
    ),
    OnboardingSlide(
      image: 'assets/onboard4.png',
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
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
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
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0), // Left margin
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Background color
                        onPrimary: Colors.black, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0), // Border radius
                          side: BorderSide(color: Colors.black, width: 2.0), // Border
                        ),
                      ),
                      child: Text('Planlar'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0), // Horizontal margin
              width: double.infinity, // Full width
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement another button functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2355FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0), // Border radius
                  ),
                ),
                child: const Text('Ana Sayfa', style: TextStyle(color: Colors.white),
               // Background color
                ),
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      )
          : SizedBox.shrink()
          : SizedBox.shrink(),

    );
  }
}

class OnboardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool hasButton;

  const OnboardingSlide({
    required this.image,
    required this.title,
    required this.description,
    this.hasButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 296,
            child: Image.asset(image),
          ),
          SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: title
                .split(' ')
                .map((word) => Text(word, style: TextStyle(fontSize: 48.0)))
                .toList(),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
