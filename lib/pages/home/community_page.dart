import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_button.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
import 'package:voxpollui/class/widget_class.dart';
import 'package:voxpollui/pages/communitys.dart';

// ignore: must_be_immutable
class CommunityPage extends StatefulWidget {
  final int pageIndex;
  List<Map<String, dynamic>>? pollObjects;
  List<Map<String, dynamic>>? usersObjects;
  List<Map<String, dynamic>>? commObjects;

  CommunityPage(this.pageIndex,
      {super.key,
      required this.pollObjects,
      required this.usersObjects,
      required this.commObjects});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: AppColor.nationalColor,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    hintText: 'Topluluk Ara',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 101, 101, 101),
                        fontSize: 14,
                        fontFamily: GetFont.GILROY_MEDIUM)),
                onSubmitted: (value) {},
              ),
            ),
            Expanded(
              child: widget.usersObjects == null
                  ? LoadingScreen.loadingScreen(text: '')
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NationalButton.nationalButton(
                              text: "Topluluk Oluştur",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateCommunityPage(
                                              usersObjects: widget.usersObjects,
                                              pollObjects: widget.pollObjects,
                                            )));
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
                        /*
                        ...List.generate(
                            widget.usersObjects!.length,
                            (index) => ForWidget.buildCardCommunity(
                                  context,
                                  index,
                                  widget.pollObjects,
                                  widget.usersObjects,
                                )),
                                */
                        ForWidget.buildCardCommunity(
                          context,
                          1,
                          widget.pollObjects,
                          widget.usersObjects,
                        ),
                        ForWidget.buildCardCommunity(
                          context,
                          2,
                          widget.pollObjects,
                          widget.usersObjects,
                        ),
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
                                    context,
                                    index,
                                    widget.pollObjects,
                                    widget.usersObjects)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
