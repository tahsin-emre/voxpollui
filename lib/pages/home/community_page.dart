import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/widget_class.dart';

// ignore: must_be_immutable
class CommunityPage extends StatefulWidget {
  final int pageIndex;
  List<Map<String, dynamic>>? pollObjects;
  List<Map<String, dynamic>>? usersObjects;

  CommunityPage(this.pageIndex, {super.key, required this.pollObjects, required this.usersObjects});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40.0,
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
            Expanded(
              child: widget.usersObjects == null
                  ? LoadingScreen.loading_screen(text: "Yükleniyor")
                  : ListView(
                      children: [
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Topluluklarım',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ...List.generate(
                            widget.usersObjects!.length,
                            (index) =>
                                ForWidget.buildCardCommunity(context, index, widget.pollObjects, widget.usersObjects)),
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Önerilen Topluluklar',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ...List.generate(
                            widget.usersObjects!.length,
                            (index) =>
                                ForWidget.buildCardCommunityWithJoinButton(
                                    context, index, widget.pollObjects, widget.usersObjects)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
