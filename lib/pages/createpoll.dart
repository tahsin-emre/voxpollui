import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/custom/custom_textfield.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/pages/home_page.dart';

class CreatePollPage extends StatefulWidget {
  const CreatePollPage({super.key});

  @override
  State<CreatePollPage> createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final List<TextEditingController> _optionControllers =
      List.generate(4, (index) => TextEditingController());

  void _addTextField() {
    if (_optionControllers.length >= 8) {
      // Eğer 8'den fazla TextField varsa, kullanıcıya bir mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('En fazla 8 adet alan ekleyebilirsiniz.'),
        ),
      );
    } else {
      setState(() {
        _optionControllers.add(TextEditingController());
      });
    }
  }


  Future<void> _createPoll() async {
    final String title = _titleController.text.trim();
    final List<String> options =
        _optionControllers.map((controller) => controller.text.trim()).toList();

    if (title.isEmpty || options.any((option) => option.isEmpty)) {
      // Hata mesajı göster
      return;
    }

    // Mevcut kullanıcıyı al
    final ParseUser currentUser = await ParseUser.currentUser();

    final ParseObject poll = ParseObject('Poll')
      ..set('title', title)
      ..set('createdBy',
          currentUser.objectId); // Kullanıcının objectId'sini kaydet

    final response = await poll.save();

    if (response.success && response.result != null) {
      final pollId = response.result.objectId;
      for (var option in options) {
        final ParseObject pollOption = ParseObject('PollOption')
          ..set('text', option)
          ..set('pollId', pollId);
        await pollOption.save();
      }
      // Anket başarıyla kaydedildi mesajı göster ve ana sayfaya yönlendir
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => const HomePage())));
    } else {
      // Hata mesajı göster
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedValue = 'Seçenek 1';
    List<String> options = ['Seçenek 1', 'Seçenek 2', 'Seçenek 3'];
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Anket Oluştur'),
          ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Anket Oluştur",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                PollTextField.pollTextField(
                    controller: _titleController,
                    context: context,
                    labelText: "Anket Başlığı"),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Seçenekler",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ..._optionControllers
                    .map((controller) => PollTextField.pollTextField(
                          controller: controller,
                          labelText: "1.",
                          context: context,
                        )),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _addTextField,
                        icon: Icon(
                          Icons.add_box_rounded,
                          color: AppColor.nationalColor,
                        ),
                      ),
                      Text('Seçenek Ekle', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kategori', 
                        style: TextStyle(
                          color: Colors.black, 
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ),
                    DropdownButton(
                      value: selectedValue,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _createPoll,
                  child: const Text('Anket Oluştur'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
