import 'package:flutter/material.dart';
import 'package:voxpollui/boarding/for_pro/boarding_for_pro_iki.dart';
import 'package:voxpollui/home_page.dart';

void main() {
  runApp(VoxpollPro());
}

class VoxpollPro extends StatefulWidget {
  @override
  _VoxpollProState createState() => _VoxpollProState();
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
              border: Border.all(color: Color(0xFFBCBCBC), width: 1), // Burada sınırın rengini ve genişliğini ayarlayabilirsiniz
              borderRadius: BorderRadius.circular(5), // Sınırın yuvarlak köşelerini ayarlamak için
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Planlar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
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
                indicatorPadding: EdgeInsets.all(5), // Seçili tab göstergesinin padding'i
                indicatorSize: TabBarIndicatorSize.tab, // Gösterge boyutu tab ile aynı olacak
                indicatorWeight: 3, // Gösterge kalınlığı
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
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
                indicatorPadding: EdgeInsets.all(5), // Seçili tab göstergesinin padding'i
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
             Container(
           width: MediaQuery.of(context).size.width,
           height: 49,
         child: Stack(
            children: [
               Align(
         alignment: Alignment.bottomCenter,
         child: ElevatedButton(
   onPressed: () {
     Navigator.push(context, MaterialPageRoute(builder: (context) => VoxpollProIki()));
   },
  style: ElevatedButton.styleFrom(
    backgroundColor : Color(0xFF2355FF), // Arkaplan rengi
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Kenarlık şekli
   ),
   child: Padding(
    padding: const EdgeInsets.all(8.0),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: price.isNotEmpty ? Text(
          price,
          style: TextStyle(fontWeight: FontWeight.bold),
        ) : null,
      ),
    );
  }
}

String text(String deger) {
  Text text = Text(
    deger,
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Color(0xFF0C0C0C),
    fontSize: 14,
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w600,
    height: 0,
    ),
  );
  return text.data ?? 'null';
}



// import 'package:flutter/material.dart';
// import 'package:voxpollui/boarding/for_pro/boarding_for_pro_iki.dart';

// void main() {
//   runApp(const VoxpollPro());
// }

// // Generated by: https://www.figma.com/community/plugin/842128343887142055/
// class VoxpollPro extends StatelessWidget {
//   const VoxpollPro({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
//       ),
//       home: Scaffold(
//         body: Container(
//   width: 428,
//   height: 926,
//   clipBehavior: Clip.antiAlias,
//   decoration: ShapeDecoration(
//     color: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(32),
//     ),
//   ),
//   child: Stack(
//     children: [
//       Positioned(
//         left: 31,
//         top: 843,
//         child: Container(
//           width: 366,
//           height: 49,
//           child: Stack(
//             children: [
//               Align(
//         alignment: Alignment.bottomCenter,
//         child: ElevatedButton(
//   onPressed: () {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => VoxpollProIki()));
//   },
//   style: ElevatedButton.styleFrom(
//     primary: Color(0xFF2355FF), // Arkaplan rengi
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Kenarlık şekli
//   ),
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Text(
//       'İleri',
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 16,
//         fontFamily: 'Gilroy',
//         fontWeight: FontWeight.w700,
//         height: 0,
//       ),
//     ),
//   ),
// )
//       ),
//             ],
//           ),
//         ),
//       ),
//       // Positioned(
//       //   left: 0,
//       //   top: 0,
//       //   child: Container(
//       //     width: 428,
//       //     height: 47,
//       //     clipBehavior: Clip.antiAlias,
//       //     decoration: BoxDecoration(),
//       //     child: Stack(
//       //       children: [
//       //         Positioned(
//       //           left: 33,
//       //           top: 14,
//       //           child: Container(
//       //             width: 54,
//       //             height: 21,
//       //             padding: const EdgeInsets.only(top: 1),
//       //             decoration: ShapeDecoration(
//       //               shape: RoundedRectangleBorder(
//       //                 borderRadius: BorderRadius.circular(24),
//       //               ),
//       //             ),
//       //             child: Row(
//       //               mainAxisSize: MainAxisSize.min,
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               crossAxisAlignment: CrossAxisAlignment.center,
//       //               children: [
//       //                 SizedBox(
//       //                   width: 54,
//       //                   height: 20,
//       //                   child: Text(
//       //                     '9:41',
//       //                     textAlign: TextAlign.center,
//       //                     style: TextStyle(
//       //                       color: Color(0xFF010101),
//       //                       fontSize: 17,
//       //                       fontFamily: 'SF Pro Text',
//       //                       fontWeight: FontWeight.w600,
//       //                       height: 0.08,
//       //                       letterSpacing: -0.41,
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ],
//       //             ),
//       //           ),
//       //         ),
//       //         Positioned(
//       //           left: 318,
//       //           top: 19,
//       //           child: Container(
//       //             width: 77.40,
//       //             height: 13,
//       //             child: Stack(
//       //               children: [
//       //                 Positioned(
//       //                   left: 50,
//       //                   top: 0,
//       //                   child: Container(
//       //                     width: 27.40,
//       //                     height: 13,
//       //                     child: Stack(children: [
                          
//       //                     ]),
//       //                   ),
//       //                 ),
//       //                 Positioned(
//       //                   left: 26,
//       //                   top: 1,
//       //                   child: Container(
//       //                     width: 17,
//       //                     height: 12,
//       //                     decoration: BoxDecoration(
//       //                       image: DecorationImage(
//       //                         image: NetworkImage("https://via.placeholder.com/17x12"),
//       //                         fit: BoxFit.fill,
//       //                       ),
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ],
//       //             ),
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       Positioned(
//         left: 26,
//         top: 127,
//         child: Text(
//           'Planlar',
//           style: TextStyle(
//             color: Color(0xFF0C0C0C),
//             fontSize: 24,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w700,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 31,
//         top: 166,
//         child: Container(
//           width: 366,
//           height: 39,
//           decoration: ShapeDecoration(
//             color: Color(0xFFD9D9D9),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//       Positioned(
//         left: 31,
//         top: 215,
//         child: Container(
//           width: 366,
//           height: 39,
//           decoration: ShapeDecoration(
//             color: Color(0xFFD9D9D9),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//       Positioned(
//         left: 34,
//         top: 169,
//         child: Container(
//           width: 177,
//           height: 33,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             shadows: [
//               BoxShadow(
//                 color: Color(0x0A000000),
//                 blurRadius: 2,
//                 offset: Offset(0, 2),
//                 spreadRadius: 0,
//               ),
//               BoxShadow(
//                 color: Color(0x0A000000),
//                 blurRadius: 4,
//                 offset: Offset(0, 4),
//                 spreadRadius: 0,
//               )
//             ],
//           ),
//         ),
//       ),
//       Positioned(
//         left: 34,
//         top: 218,
//         child: Container(
//           width: 177,
//           height: 33,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             shadows: [
//               BoxShadow(
//                 color: Color(0x0A000000),
//                 blurRadius: 2,
//                 offset: Offset(0, 2),
//                 spreadRadius: 0,
//               ),
//               BoxShadow(
//                 color: Color(0x0A000000),
//                 blurRadius: 4,
//                 offset: Offset(0, 4),
//                 spreadRadius: 0,
//               )
//             ],
//           ),
//         ),
//       ),
//       Positioned(
//         left: 278,
//         top: 179,
//         child: Text(
//           'Bireysel',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Color(0xFF646464),
//             fontSize: 14,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w600,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 288,
//         top: 228,
//         child: Text(
//           'Yıllık',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Color(0xFF646464),
//             fontSize: 14,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w600,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 91,
//         top: 179,
//         child: Text(
//           'Kurumsal',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Color(0xFF0C0C0C),
//             fontSize: 14,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w600,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 106,
//         top: 228,
//         child: Text(
//           'Aylık',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Color(0xFF0C0C0C),
//             fontSize: 14,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w600,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 26,
//         top: 64,
//         child: Container(
//           width: 40,
//           height: 40,
//           child: Stack(
//             children: [
//               Positioned(
//                 left: 0,
//                 top: 0,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(width: 1, color: Color(0xFFBCBCBC)),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       Positioned(
//         left: 31,
//         top: 276,
//         child: Container(
//           width: 366,
//           height: 98,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               side: BorderSide(width: 2, color: Color(0xFFD9D9D9)),
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//         ),
//       ),
//       Positioned(
//         left: 31,
//         top: 389,
//         child: Container(
//           width: 366,
//           height: 98,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               side: BorderSide(width: 2, color: Color(0xFFD9D9D9)),
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//         ),
//       ),
//       Positioned(
//         left: 51,
//         top: 292,
//         child: Text(
//           'Premium',
//           style: TextStyle(
//             color: Color(0xFF0C0C0C),
//             fontSize: 16,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w700,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 51,
//         top: 405,
//         child: Text(
//           'VoxPoll Pro',
//           style: TextStyle(
//             color: Color(0xFF0C0C0C),
//             fontSize: 16,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w700,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 51,
//         top: 317,
//         child: Text(
//           'Aylık 1000 adet anket açabilir ve 1.000.000 kişiye\nkadar katılım sağlayabilirsiniz.',
//           style: TextStyle(
//             color: Color(0xFF0C0C0C),
//             fontSize: 14,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w500,
//             height: 0,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 51,
//         top: 430,
//         child: Text.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                 text: 'İstediğiniz özellikleri alabilmek için lütfen bizimle\n',
//                 style: TextStyle(
//                   color: Color(0xFF0C0C0C),
//                   fontSize: 14,
//                   fontFamily: 'Gilroy',
//                   fontWeight: FontWeight.w500,
//                   height: 0,
//                 ),
//               ),
//               TextSpan(
//                 text: 'info@voxpoll.app',
//                 style: TextStyle(
//                   color: Color(0xFF0C0C0C),
//                   fontSize: 14,
//                   fontFamily: 'Gilroy',
//                   fontWeight: FontWeight.w900,
//                   height: 0,
//                 ),
//               ),
//               TextSpan(
//                 text: ' adresinden iletişime geçin.',
//                 style: TextStyle(
//                   color: Color(0xFF0C0C0C),
//                   fontSize: 14,
//                   fontFamily: 'Gilroy',
//                   fontWeight: FontWeight.w500,
//                   height: 0,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       Positioned(
//         left: 319,
//         top: 292,
//         child: Text(
//           '1000 TL',
//           textAlign: TextAlign.right,
//           style: TextStyle(
//             color: Color(0xFF2355FF),
//             fontSize: 16,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w900,
//             height: 0,
//           ),
//         ),
//       ),
//     ],
//   ),
// )
//       ),
//     );
//   }
// }

// class VoxpollPro extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 428,
//           height: 926,
//           clipBehavior: Clip.antiAlias,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(32),
//             ),
//           ),
//           child: Stack(
//             children: [
//               Positioned(
//                 left: 31,
//                 top: 843,
//                 child: Container(
//                   width: 366,
//                   height: 49,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: 0,
//                         top: 0,
//                         child: Container(
//                           width: 366,
//                           height: 49,
//                           decoration: ShapeDecoration(
//                             color: Color(0xFF2355FF),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 171,
//                         top: 18,
//                         child: Text(
//                           'İleri',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontFamily: 'Gilroy',
//                             fontWeight: FontWeight.w700,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 top: 0,
//                 child: Container(
//                   width: 428,
//                   height: 47,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: 33,
//                         top: 14,
//                         child: Container(
//                           width: 54,
//                           height: 21,
//                           padding: const EdgeInsets.only(top: 1),
//                           decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(24),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 54,
//                                 height: 20,
//                                 child: Text(
//                                   '9:41',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Color(0xFF010101),
//                                     fontSize: 17,
//                                     fontFamily: 'SF Pro Text',
//                                     fontWeight: FontWeight.w600,
//                                     height: 0.08,
//                                     letterSpacing: -0.41,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 318,
//                         top: 19,
//                         child: Container(
//                           width: 77.40,
//                           height: 13,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 left: 50,
//                                 top: 0,
//                                 child: Container(
//                                   width: 27.40,
//                                   height: 13,
//                                   child: Stack(children: [
                                  
//                                   ]),
//                                 ),
//                               ),
//                               Positioned(
//                                 left: 26,
//                                 top: 1,
//                                 child: Container(
//                                   width: 17,
//                                   height: 12,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage("https://via.placeholder.com/17x12"),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 26,
//                 top: 127,
//                 child: Text(
//                   'Planlar',
//                   style: TextStyle(
//                     color: Color(0xFF0C0C0C),
//                     fontSize: 24,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w700,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 31,
//                 top: 166,
//                 child: Container(
//                   width: 366,
//                   height: 39,
//                   decoration: ShapeDecoration(
//                     color: Color(0xFFD9D9D9),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 31,
//                 top: 215,
//                 child: Container(
//                   width: 366,
//                   height: 39,
//                   decoration: ShapeDecoration(
//                     color: Color(0xFFD9D9D9),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 34,
//                 top: 169,
//                 child: Container(
//                   width: 177,
//                   height: 33,
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     shadows: [
//                       BoxShadow(
//                         color: Color(0x0A000000),
//                         blurRadius: 2,
//                         offset: Offset(0, 2),
//                         spreadRadius: 0,
//                       )BoxShadow(
//                         color: Color(0x0A000000),
//                         blurRadius: 4,
//                         offset: Offset(0, 4),
//                         spreadRadius: 0,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 34,
//                 top: 218,
//                 child: Container(
//                   width: 177,
//                   height: 33,
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     shadows: [
//                       BoxShadow(
//                         color: Color(0x0A000000),
//                         blurRadius: 2,
//                         offset: Offset(0, 2),
//                         spreadRadius: 0,
//                       ),
//                       BoxShadow(
//                         color: Color(0x0A000000),
//                         blurRadius: 4,
//                         offset: Offset(0, 4),
//                         spreadRadius: 0,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 278,
//                 top: 179,
//                 child: Text(
//                   'Bireysel',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xFF646464),
//                     fontSize: 14,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w600,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 288,
//                 top: 228,
//                 child: Text(
//                   'Yıllık',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xFF646464),
//                     fontSize: 14,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w600,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 91,
//                 top: 179,
//                 child: Text(
//                   'Kurumsal',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xFF0C0C0C),
//                     fontSize: 14,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w600,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 106,
//                 top: 228,
//                 child: Text(
//                   'Aylık',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xFF0C0C0C),
//                     fontSize: 14,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w600,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 26,
//                 top: 64,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: 0,
//                         top: 0,
//                         child: Container(
//                           width: 40,
//                           height: 40,
//                           decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(width: 1, color: Color(0xFFBCBCBC)),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 31,
//                 top: 276,
//                 child: Container(
//                   width: 366,
//                   height: 98,
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(width: 2, color: Color(0xFFD9D9D9)),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 31,
//                 top: 389,
//                 child: Container(
//                   width: 366,
//                   height: 98,
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(width: 2, color: Color(0xFFD9D9D9)),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 51,
//                 top: 292,
//                 child: Text(
//                   'Premium',
//                   style: TextStyle(
//                     color: Color(0xFF0C0C0C),
//                     fontSize: 16,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w700,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 51,
//                 top: 405,
//                 child: Text(
//                   'VoxPoll Pro',
//                   style: TextStyle(
//                     color: Color(0xFF0C0C0C),
//                     fontSize: 16,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w700,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 51,
//                 top: 317,
//                 child: Text(
//                   'Aylık 1000 adet anket açabilir ve 1.000.000 kişiye\nkadar katılım sağlayabilirsiniz.',
//                   style: TextStyle(
//                     color: Color(0xFF0C0C0C),
//                     fontSize: 14,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w500,
//                     height: 0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 51,
//                 top: 430,
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'İstediğiniz özellikleri alabilmek için lütfen bizimle\n',
//                         style: TextStyle(
//                           color: Color(0xFF0C0C0C),
//                           fontSize: 14,
//                           fontFamily: 'Gilroy',
//                           fontWeight: FontWeight.w500,
//                           height: 0,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'info@voxpoll.app',
//                         style: TextStyle(
//                           color: Color(0xFF0C0C0C),
//                           fontSize: 14,
//                           fontFamily: 'Gilroy',
//                           fontWeight: FontWeight.w900,
//                           height: 0,
//                         ),
//                       ),
//                       TextSpan(
//                         text: ' adresinden iletişime geçin.',
//                         style: TextStyle(
//                           color: Color(0xFF0C0C0C),
//                           fontSize: 14,
//                           fontFamily: 'Gilroy',
//                           fontWeight: FontWeight.w500,
//                           height: 0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 319,
//                 top: 292,
//                 child: Text(
//                   '1000 TL',
//                   textAlign: TextAlign.right,
//                   style: TextStyle(
//                     color: Color(0xFF2355FF),
//                     fontSize: 16,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.w900,
//                     height: 0,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }