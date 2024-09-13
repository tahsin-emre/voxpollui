import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/custom/custom_appbar.dart';
import 'package:voxpollui/class/custom/custom_button.dart';
import 'package:voxpollui/class/model/custom_model/textfield_model.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/model/national/get_font.dart';
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
  TextEditingController communityName = TextEditingController();
  bool switchValue = true;
  String publicPrivate = "Herkese Açık";

  String? selectedCategory;

  List<String> interests = [];

  @override
  void initState() {
    super.initState();
    _fetchInterests();
  }

  Future<void> _fetchInterests() async {
    final ParseResponse response = await ParseObject('Interest').getAll();
    if (response.success && response.results != null) {
      setState(() {
        interests = response.results!
            .map((e) => e.get<String>('name') as String)
            .toList();
      });
    } else {
      // Handle error
    }
  }

  List<String> categories = [
    'Ekonomi',
    'Siyaset',
    'Oyun',
  ];

  String username = '';

  final TextEditingController callUsers = TextEditingController();
  // final FocusNode _focusNode = FocusNode();

  void addCallUsers() {
    if (callUsers.text.isEmpty) {
      callUsers.text = "";
    } else {
      callUsers.text = username;
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode.addListener(() {
  //     if (_focusNode.hasFocus && callUsers.text.isEmpty) {
  //       callUsers.text = '+90 ';
  //       callUsers.selection = TextSelection.fromPosition(
  //         TextPosition(offset: callUsers.text.length),
  //       );
  //     }
  //   });
  //   callUsers.addListener(() {
  //     final text = callUsers.text;
  //     if (!text.startsWith('+90 ')) {
  //       callUsers.text = '+90 ${text.replaceAll('+90 ', '')}';
  //       callUsers.selection = TextSelection.fromPosition(
  //         TextPosition(offset: callUsers.text.length),
  //       );
  //     }
  //   });
  // }

  List<FieldOption> _options = [FieldOption(), FieldOption(), FieldOption()];

  Future<void> _pickImage(FieldOption option) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        option.image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.customAppBar(context, ""),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Topluluk Oluştur",
                    style: TextStyle(
                        fontSize: 24, fontFamily: GetFont.GILROY_BOLD),
                  ),
                ),
                /*
                child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset('assets/image/add_image.svg'),
                        onPressed: () => _pickImage(_options.first),
                      ),
                      label: Text(
                        "Anket Başlığı",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: GetFont.GILROY_MEDIUM,
                            fontSize: 18),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.nationalColor)),
                    ),
                  ),
                */
                TextField(
                  controller: communityName,
                  scrollPadding: const EdgeInsets.all(0.0),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: SvgPicture.asset('assets/image/add_image.svg'),
                        onPressed: () => _pickImage(_options.first),
                      ),
                    labelText: 'Topluluk Adı',
                    border: const UnderlineInputBorder(),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.nationalColor),
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                    focusColor: AppColor.nationalColor,
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
                DropdownMenu<String>(
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  width: MediaQuery.of(context).size.width,
                  initialSelection: interests.first,
                  dropdownMenuEntries:
                      interests.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
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
                  controller: callUsers,
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
                      callUsers.text = username;
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
