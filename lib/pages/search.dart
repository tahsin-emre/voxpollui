import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_tabbar.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
import 'package:voxpollui/class/widget_class.dart';
import 'package:voxpollui/pages/home_page.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
  final int pageIndex;
  List<Map<String, dynamic>>? pollObjects;
  List<Map<String, dynamic>>? usersObjects;
  Search(this.pageIndex,
      {super.key, required this.pollObjects, required this.usersObjects});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  //int _selectedTabIndex = 0;
  late TabController _tabController;

  List<String> tabText = ["Tümü", "Kişiler", "Topluluk", "Anketler"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabText.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            cursorColor: AppColor.nationalColor,
            decoration: const InputDecoration(
              hintText: 'Fener',
              hintStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.search, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CustomTabbar.customTabbar(_tabController, tabText),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Anketler',
                  style: TextStyle(
                      fontSize: 18, fontFamily: GetFont.GILROY_MEDIUM),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: Text(
                    'Tümünü Görüntüle',
                    style: TextStyle(
                        fontSize: 14, fontFamily: GetFont.GILROY_BOLD),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.pollObjects?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ForWidget.buildCard(
                    context,
                    widget.usersObjects!,
                    widget.pollObjects!,
                    index,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Kişiler',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Tümünü Görüntüle',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.usersObjects?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ForWidget.buildCardCommunity(
                    context,
                    index,
                    widget.pollObjects,
                    widget.usersObjects,
                  );
                },
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
