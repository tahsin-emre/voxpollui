import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CreatePollPage extends StatefulWidget {
  @override
  _CreatePollPageState createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(4, (index) => TextEditingController());

  Future<void> _createPoll() async {
    final String title = _titleController.text.trim();
    final List<String> options = _optionControllers.map((controller) => controller.text.trim()).toList();

    if (title.isEmpty || options.any((option) => option.isEmpty)) {
      // Hata mesajı göster
      return;
    }

    // Mevcut kullanıcıyı al
    final ParseUser currentUser = await ParseUser.currentUser() as ParseUser;

    final ParseObject poll = ParseObject('Poll')
      ..set('title', title)
      ..set('createdBy', currentUser.objectId); // Kullanıcının objectId'sini kaydet

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
      Navigator.pop(context);
    } else {
      // Hata mesajı göster
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anket Oluştur'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Anket Başlığı'),
            ),
            ..._optionControllers.map((controller) => TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Seçenek'),
            )),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _createPoll,
              child: Text('Anket Oluştur'),
            ),
          ],
        ),
      ),
    );
  }
}
