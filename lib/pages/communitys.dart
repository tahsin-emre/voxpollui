import 'package:flutter/material.dart';
import 'package:voxpollui/class/custom/custom_button.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/widget_class.dart';

// ignore: must_be_immutable
class CreateCommunityPage extends StatefulWidget {
  List<Map<String, dynamic>>? pollObjects;
  List<Map<String, dynamic>>? usersObjects;
  CreateCommunityPage({
    super.key,
    required this.pollObjects,
    required this.usersObjects,
  });

  @override
  State<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends State<CreateCommunityPage> {
  TextEditingController community_name = TextEditingController();
  bool switchValue = true;
  String publicPrivate = "Herkese Açık";

  String? selectedCategory;

  List<String> categories = [
    'Ekonomi',
    'Siyaset',
    'Oyun',
    'Ekonomi',
    'Siyaset',
    'Oyun',
    'Ekonomi',
    'Siyaset',
    'Oyun',
    'Ekonomi',
    'Siyaset',
    'Oyun',
    'Ekonomi',
    'Siyaset',
    'Oyun'
  ];

  String username = '';

  final TextEditingController call_users = TextEditingController();
  // final FocusNode _focusNode = FocusNode();

  void addCallUsers() {
    if (call_users.text.isEmpty) {
      call_users.text = "";
    } else {
      call_users.text = username;
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode.addListener(() {
  //     if (_focusNode.hasFocus && call_users.text.isEmpty) {
  //       call_users.text = '+90 ';
  //       call_users.selection = TextSelection.fromPosition(
  //         TextPosition(offset: call_users.text.length),
  //       );
  //     }
  //   });
  //   call_users.addListener(() {
  //     final text = call_users.text;
  //     if (!text.startsWith('+90 ')) {
  //       call_users.text = '+90 ${text.replaceAll('+90 ', '')}';
  //       call_users.selection = TextSelection.fromPosition(
  //         TextPosition(offset: call_users.text.length),
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Topluluk Oluştur"),
                ),
                TextField(
                  controller: community_name,
                  decoration: InputDecoration(
                    labelText: 'Topluluk Adı',
                    border: const UnderlineInputBorder(),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.nationalColor),
                    ),
                  ),
                  cursorColor: AppColor.nationalColor,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kategori',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: selectedCategory,
                  hint: const Text('Kategori Seçiniz'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'İnsanları Davet Edin',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: call_users,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    hintText: 'Kullanıcı Adı',
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
                  ),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      call_users.text = username;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        publicPrivate,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Switch(
                            value: switchValue,
                            onChanged: (newValue) {
                              setState(() {
                                switchValue = newValue;
                                publicPrivate = newValue
                                    ? "Sadece Takipçiler"
                                    : "Herkese Açık";
                              });
                            },
                            inactiveTrackColor: Colors.white,
                            activeColor: AppColor.nationalColor,
                            inactiveThumbColor: AppColor.nationalColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: NationalButton.nationalButton(
                    text: "Topluluk Oluştur",
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Topluluklarım',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Check if usersObjects is not null and not empty
                if (widget.usersObjects != null &&
                    widget.usersObjects!.isNotEmpty)
                  ...List.generate(
                    widget.usersObjects!.length,
                    (index) {
                      // Additional null checks for pollObjects
                      return ForWidget.buildCardCommunity(
                        context,
                        index,
                        widget.pollObjects ??
                            [], // Fallback to empty list if null
                        widget.usersObjects!,
                      );
                    },
                  )
                else
                  const Text('No communities available.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
