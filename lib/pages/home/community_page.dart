import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_button.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/widget_class.dart';
import 'package:voxpollui/pages/communitys.dart';

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                  hintText: 'Ara',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: widget.usersObjects == null
                  ? LoadingScreen.loadingScreen(text: '')
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NationalButton.nationalButton(text: "Topluluk Oluştur", onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCommunityPage(usersObjects: widget.usersObjects, pollObjects: widget.pollObjects,)));
                          }),
                        ),
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
