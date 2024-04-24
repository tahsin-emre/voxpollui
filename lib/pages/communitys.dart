import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool switchValue = false;
  String publicPrivate = "Herkese Açık";

  String? selectedCategory;

  List<String> categories = ['Kategori 1', 'Kategori 2', 'Kategori 3']; // Var olan kategoriler


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Topluluk Oluştur")
                ),
                TextField(                
                  controller: community_name,
                  decoration: InputDecoration(
                    labelText: 'Topluluk Adı',
                    border: UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.nationalColor)
                    ),
                  ),cursorColor: AppColor.nationalColor,
                ),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                        'Kategori',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                ),
                const SizedBox(height: 20,),

                DropdownButtonFormField(
                  value: selectedCategory,
                  hint: Text('Kategori Seçiniz'), // Kullanıcı henüz bir kategori seçmediğinde görüntülenecek metin
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
                // TextField(
                //   decoration: InputDecoration(
                //     contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                //     hintText: 'Politika',
                //     prefixIcon: Icon(Icons.search),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //       borderSide: BorderSide(color: Colors.black),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //       borderSide: BorderSide(color: Colors.black),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //       borderSide: BorderSide(color: Colors.black),
                //     ),
                //   ),
                //   autocorrect: true, // Yazarken otomatik düzeltme özelliği
                //   // options: ['Politika', 'Pazarlama', 'Proje Yönetimi', 'Programlama', ...],
                // ),

                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                        'İnsanları Davet Edin',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    hintText: 'Kullanıcı Adı',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          publicPrivate,
                          style: TextStyle(
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
                                  newValue ? publicPrivate = "Sadece Takipçiler" : publicPrivate = "Herkese Açık";
                                  print(newValue);
                                });
                              },
                              inactiveTrackColor: Colors.white, // Pasifken track'in rengi
                              activeColor: AppColor.nationalColor, // Aktif durumda topun rengi
                              inactiveThumbColor: AppColor.nationalColor, // Pasif durumda topun rengi
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: NationalButton.nationalButton(text: "Topluluk Oluştur", onPressed: () {})
                ),
                SizedBox(height: 10,),
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
                    ForWidget.buildCardCommunity(context, index, widget.pollObjects, widget.usersObjects)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}