import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/custom/custom_textfield.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/home_page.dart';

class CreatePollPage extends StatefulWidget {
  const CreatePollPage({super.key});

  @override
  State<CreatePollPage> createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _optionControllers =
      List.generate(4, (index) => TextEditingController());

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
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Anket Oluştur'),
          ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Anket Oluştur",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              PollTextField.pollTextField(titleController: _titleController, context: context),
              ..._optionControllers.map((controller) => TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Seçenek'),
                  )),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _createPoll,
                child: const Text('Anket Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
