import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: [
          OnboardingPage(
            imagePath: 'assets/onboarding1.png', // İlk görselin yolu
            title: 'Artık Anket Zamanı',
            description:
                'İlgi alanlarınızla veya firmanızla ilgili bütün merak ettiklerinizin cevaplarını öğrenmek artık çok kolay.',
          ),
          OnboardingPage(
            imagePath: 'assets/onboarding2.png', // İkinci görselin yolu
            title: 'İlgi Alanlarını Belirle',
            description:
                'Seçtiğiniz ilgi alanlarınıza göre anlık olarak tüm anketleri cevaplayabilir veya sonuçları inceleyebilirsiniz.',
          ),
          OnboardingPage(
            imagePath: 'assets/onboarding3.png', // Üçüncü görselin yolu
            title: 'Sınırsız Ankete Katıl',
            description:
                'İstediğiniz kadar ankete katılıp dilerseniz VoxPoll Premium abonesi olup anket açıp sonuçları inceleyebilirsiniz.',
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 300,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Icon(
            Icons.settings,
            size: 32,
          ),
        ],
      ),
    );
  }
}
