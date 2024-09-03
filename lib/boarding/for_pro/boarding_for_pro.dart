import 'package:flutter/material.dart';
import 'package:voxpollui/boarding/for_pro/boarding_for_pro_iki.dart';
import 'package:voxpollui/pages/home_page.dart';

void main() {
  runApp(const VoxpollPro());
}

class VoxpollPro extends StatefulWidget {
  const VoxpollPro({super.key});

  @override
  State<VoxpollPro> createState() => _VoxpollProState();
}

class _VoxpollProState extends State<VoxpollPro> with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _subTabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _subTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _subTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xFFBCBCBC),
                  width: 1), // Sınırın rengini ve genişliğini ayarlar
              borderRadius: BorderRadius.circular(
                  5), // Sınırın yuvarlak köşelerini ayarlar
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.black), // Geri ok simgesinin rengi
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Planlar',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Gilroy-medium",
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
                height: 16), // Planlar başlığı ile TabBar arasına boşluk ekler
            Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10), // Seçili Tab'ın kenarlarını yuvarlatır
                  color: Colors
                      .white, // Seçili Tab'ın arka plan rengini beyaz yapar
                ),
                labelColor:
                    Colors.black, // Seçili Tab'ın metin rengini siyah yapar
                unselectedLabelColor: Colors
                    .grey, // Seçili olmayan Tab'ların metin rengini gri yapar
                tabs: const [
                  Tab(text: 'Kurumsal'),
                  Tab(text: 'Bireysel'),
                ],
                indicatorPadding: const EdgeInsets.all(
                    5), // Seçili Tab göstergesinin padding'i
                indicatorSize: TabBarIndicatorSize
                    .tab, // Gösterge boyutunu tab ile aynı yapar
                indicatorWeight: 3, // Gösterge kalınlığını ayarlar
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TabBar(
                controller: _subTabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10), // Seçili Tab'ın kenarlarını yuvarlatır
                  color: Colors
                      .white, // Seçili Tab'ın arka plan rengini beyaz yapar
                ),
                labelColor:
                    Colors.black, // Seçili Tab'ın metin rengini siyah yapar
                unselectedLabelColor: Colors
                    .grey, // Seçili olmayan Tab'ların metin rengini gri yapar
                tabs: const [
                  Tab(text: 'Aylık'),
                  Tab(text: 'Yıllık'),
                ],
                indicatorPadding: const EdgeInsets.all(
                    5), // Seçili Tab göstergesinin padding'i
                indicatorSize: TabBarIndicatorSize
                    .tab, // Gösterge boyutunu tab ile aynı yapar
                indicatorWeight: 3, // Gösterge kalınlığını ayarlar
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Kurumsal Tab Content
                  TabBarView(
                    controller: _subTabController,
                    children: [
                      // Kurumsal - Aylık
                      ListView(
                        children: [
                          planCard('Kurumsal - Aylık Premium',
                              'Aylık 1000 adet anket açabilir ve 1.000.000 kişiye kadar katılım sağlayabilirsiniz.'),
                          planCard('Kurumsal - Aylık VoxPoll Pro',
                              'İstediğiniz özellikleri alabilmek için lütfen bizimle info@voxpoll.app adresinden iletişime geçin.'),
                        ],
                      ),
                      // Kurumsal - Yıllık
                      ListView(
                        children: [
                          planCard('Kurumsal - Yıllık Premium',
                              'Yıllık 12.000 adet anket açabilir ve 1.000.000 kişiye kadar katılım sağlayabilirsiniz.'),
                          planCard('Kurumsal - Yıllık VoxPoll Pro',
                              'İstediğiniz özellikleri alabilmek için lütfen bizimle info@voxpoll.app adresinden iletişime geçin.'),
                        ],
                      ),
                    ],
                  ),
                  // Bireysel Tab Content
                  TabBarView(
                    controller: _subTabController,
                    children: [
                      // Bireysel - Aylık
                      ListView(
                        children: [
                          planCard('Bireysel - Aylık Premium',
                              'Aylık 100 adet anket açabilir ve 10.000 kişiye kadar katılım sağlayabilirsiniz.'),
                          planCard('Bireysel - Aylık VoxPoll Pro',
                              'İstediğiniz özellikleri alabilmek için lütfen bizimle info@voxpoll.app adresinden iletişime geçin.'),
                        ],
                      ),
                      // Bireysel - Yıllık
                      ListView(
                        children: [
                          planCard('Bireysel - Yıllık Premium',
                              'Yıllık 1.200 adet anket açabilir ve 10.000 kişiye kadar katılım sağlayabilirsiniz.'),
                          planCard('Bireysel - Yıllık VoxPoll Pro',
                              'İstediğiniz özellikleri alabilmek için lütfen bizimle info@voxpoll.app adresinden iletişime geçin.'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 49,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VoxpollProIki()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2355FF), // Arkaplan rengi
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)), // Kenarlık şekli
                ),
                child: const Text(
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
          ],
        ),
      ),
    );
  }

  Widget planCard(String title, String subtitle) {
    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.5), // Kenarlık rengi
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8), // Kartlar arası boşluk
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8), // Başlık ile alt başlık arasına boşluk
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
