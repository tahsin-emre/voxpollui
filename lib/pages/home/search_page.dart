import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/user.dart';
import 'package:voxpollui/class/widget_class.dart';
import 'package:voxpollui/script/database.dart';

class SearchPage extends StatefulWidget {
  final int pageIndex;

  const SearchPage(this.pageIndex, {super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Database database = Database();
  DataManager dataManager = DataManager();

  List<Map<String, dynamic>>? pollObjects;
  List<Map<String, dynamic>>? usersObjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // İçeriği Sa@feArea içerisine alın
        child: Column(
          children: [
            Container(
              height: 40.0, // Yüksekliği 40.0 piksel yapın
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8.0),
                  Text(
                    'Ara',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            // Diğer widget'larınız burada
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Keşfet',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (dataManager.getPolls()?.isEmpty ?? true) {
                          // Eğer polls null veya boş ise, yükleme göstergesi veya mesaj göster
                          return LoadingScreen.loading_screen(text: "Yükleniyor");
                        }
                        return ForWidget.buildCard(
                            context, usersObjects!, pollObjects!, index);
                      },
                      childCount: (dataManager.getPolls()?.isNotEmpty ?? false)
                          ? dataManager.getPolls()?.length
                          : 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}