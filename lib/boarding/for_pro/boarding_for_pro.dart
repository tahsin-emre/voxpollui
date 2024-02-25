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

class _VoxpollProState extends State<VoxpollPro> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFBCBCBC), width: 1), // Burada sınırın rengini ve genişliğini ayarlayabilirsiniz
              borderRadius: BorderRadius.circular(5), // Sınırın yuvarlak köşelerini ayarlamak için
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
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
                  borderRadius: BorderRadius.circular(10), // Gerekirse kenarlık yuvarlaklığı ekleyebilirsiniz
                  color: Colors.white, // Seçili Tab'ın arka plan rengi beyaz
                ),
                labelColor: Colors.black, // Seçili Tab'ın metin rengi siyah
                unselectedLabelColor: Colors.grey, // Seçilmemiş Tab'ın metin rengi gri
                tabs: [
                  Tab(text: text('Kurumsal')),
                  Tab(text: text('Bireysel')),
                ],
                indicatorPadding: const EdgeInsets.all(5), // Seçili tab göstergesinin padding'i
                indicatorSize: TabBarIndicatorSize.tab, // Gösterge boyutu tab ile aynı olacak
                indicatorWeight: 3, // Gösterge kalınlığı
              ),
            ),
            const SizedBox(height: 20,),
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
                  borderRadius: BorderRadius.circular(10), // Gerekirse kenarlık yuvarlaklığı ekleyebilirsiniz
                  color: Colors.white, // Seçili Tab'ın arka plan rengi beyaz
                ),
                labelColor: Colors.black, // Seçili Tab'ın metin rengi siyah
                unselectedLabelColor: Colors.grey, // Seçilmemiş Tab'ın metin rengi gri
                tabs: [
                  Tab(text: text('Aylık')),
                  Tab(text: text('Yıllık')),
                ],
                indicatorPadding: const EdgeInsets.all(5), // Seçili tab göstergesinin padding'i
                indicatorSize: TabBarIndicatorSize.tab, // Gösterge boyutu tab ile aynı olacak
                indicatorWeight: 3, // Gösterge kalınlığı
              ),
            ),
            // Toggle buttons for Kurumsal/Bireysel, Aylık/Yıllık would go here
            Expanded(
              child: ListView(
                children: [
                  planCard('Premium', 'Aylık 1000 adet anket çözebilir ve 1.000.000 kişiye kadar katılım sağlayabilirsiniz.', '1000 TL'),
                  planCard('VoxPoll Pro', 'İstediğiniz özellikleri alabilmek için lütfen bizimle info@voxpoll.app adresinden iletişime geçin.', ''),
                ],
              ),
            ),
             SizedBox(
           width: MediaQuery.of(context).size.width,
           height: 49,
         child: Stack(
            children: [
               Align(
         alignment: Alignment.bottomCenter,
         child: ElevatedButton(
   onPressed: () {
     Navigator.push(context, MaterialPageRoute(builder: (context) => const VoxpollProIki()));
   },
  style: ElevatedButton.styleFrom(
    backgroundColor : const Color(0xFF2355FF), // Arkaplan rengi
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Kenarlık şekli
   ),
   child: const Padding(
    padding: EdgeInsets.all(8.0),
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
 ),)
      ),
            ],
         ),      ), 
          ],
        ),
      ),
    );
  }

  Widget planCard(String title, String subtitle, String price) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: price.isNotEmpty ? Text(
          price,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ) : null,
      ),
    );
  }
}

String text(String deger) {
  Text text = Text(
    deger,
    textAlign: TextAlign.center,
    style: const TextStyle(
    color: Color(0xFF0C0C0C),
    fontSize: 14,
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w600,
    height: 0,
    ),
  );
  return text.data ?? 'null';
}