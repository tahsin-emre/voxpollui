import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class CreateCommunityPage extends StatefulWidget {
  const CreateCommunityPage({super.key});

  @override
  State<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends State<CreateCommunityPage> {

  TextEditingController community_name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
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
            ],
          ),
        ),
      ),
    );
  }
}