import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:voxpollui/class/custom/custom_button.dart';
import 'package:voxpollui/class/custom/custom_textfield.dart';
import 'package:voxpollui/class/model/custom_model/textfield_model.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/utils.dart';
import 'package:voxpollui/pages/home_page.dart';

class CreatePollPage extends StatefulWidget {
  final ValueChanged<List<String>>? onDatesSelected;
  const CreatePollPage({super.key, this.onDatesSelected});

  @override
  State<CreatePollPage> createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<FieldOption> _options = [FieldOption(), FieldOption(), FieldOption()];

  void _addTextField() {
    if (_options.length >= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('En fazla 8 adet seçenek ekleyebilirsiniz.')),
      );
    } else {
      setState(() {
        _options.add(FieldOption());
      });
    }
  }

  Future<void> _pickImage(FieldOption option) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        option.image = File(pickedFile.path);
      });
    }
  }


  List<String> _selectedDates = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  Future<ParseFileBase?> uploadImageFile(File imageFile) async {
    final parseFile = ParseFile(imageFile);

    final response = await parseFile.save();

    if (response.success) {
      return parseFile;
    } else {
      // Hata yönetimi
      print('Dosya yüklenemedi: ${response.error?.message}');
      return null;
    }
  }

  Future<void> _createPoll() async {
  final String title = _titleController.text.trim();
  final List<String> options = _options.map((option) => option.controller.text.trim()).toList();
  
  // Başlık boş ise veya seçeneklerin tamamı boş ise uyarı ver ve işlemi sonlandır
  if (title.isEmpty || options.every((option) => option.isEmpty)) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Başlık veya seçenekler boş olamaz')));
    return;
  }

  // Sadece boş olmayan seçenekleri işleme al
  final List<String> nonEmptyOptions = options.where((option) => option.isNotEmpty).toList();

  // Dosyaları asenkron olarak yükle
  List<ParseFileBase?> uploadedFiles = [];
  for (var option in _options) {
    if (option.image != null) {
      var uploadedFile = await uploadImageFile(option.image!);
      uploadedFiles.add(uploadedFile);
    } else {
      uploadedFiles.add(null); // Eşleşen dosya yoksa null ekle
    }
  }

  // Mevcut kullanıcıyı al
  final ParseUser currentUser = await ParseUser.currentUser();
  
  final ParseObject poll = ParseObject('Poll')
    ..set('title', title)
    ..set('createdBy', currentUser.objectId)
    ..set("title_image", uploadedFiles[0])
    ..set('deletedDate', _rangeEnd?.toString().substring(0, 10));

  // Burada setState kullanmanıza gerek yok çünkü widget'ın durumuyla ilgili bir değişiklik yok.
  final response = await poll.save();
  if (response.success && response.result != null) {
    final pollId = response.result.objectId;
    for (var i = 0; i < nonEmptyOptions.length; i++) {
      final ParseObject pollOption = ParseObject('PollOption')
        ..set('text', nonEmptyOptions[i])
        ..set('pollId', pollId);
        // ..set('image', uploadedFiles[i]);
      await pollOption.save();
    }
    Navigator.push(context, MaterialPageRoute(builder: ((context) => const HomePage())));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anket oluşturulamadı: ${response.error?.message}')));
  }
}



  @override
  Widget build(BuildContext context) {
    // String selectedValue = 'Seçenek 1';
    List<String> options = ['Siyaset', 'Ekonomi', 'Oyun'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Anket Oluştur",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.image, color: AppColor.nationalColor,),
                      onPressed: () => _pickImage(_options.first),
                    ),
                    label: Text("Anket Başlığı"),
                  ),
                ),
                ..._options.map((option) {
                   if (option.image != null) return Image.file(option.image!);
                   else{return Container();}
                }),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Seçenekler",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ..._options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return Column(
                    children: [
                      TextField(
                        controller: option.controller,
                        decoration: InputDecoration(
                          labelText: '${index + 1}.',
                          // suffixIcon: IconButton(
                          //   icon: const Icon(Icons.image),
                          //   onPressed: () => _pickImage(option),
                          // ),
                        ),
                      ),
                    ],
                  );
                }).toList(),

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
                      const Text(
                        'Seçenek Ekle',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Kategori',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                    Center(
                      child: DropdownMenu<String>(
                        width: MediaQuery.of(context).size.width - 50,
                        initialSelection: options.first,
                        // onSelected: (String? value) {
                        //   // This is called when the user selects an item.
                        //   setState(() {
                        //     selectedValue = value!;
                        //   });
                        // },
                        dropdownMenuEntries: options
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Anket Başlangıç ve Bitiş Tarihi',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TableCalendar(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        availableCalendarFormats: const {
                          CalendarFormat.month: '', // Sadece ay görünümü
                        },
                        headerStyle: const HeaderStyle(titleCentered: true),
                        onDaySelected: (selectedDay, focusedDay) {
                          // print("Tarihe Tıklandı");
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              _rangeStart = null; // Important to clean those
                              _rangeEnd = null;
                              _rangeSelectionMode =
                                  RangeSelectionMode.toggledOff;
                              // Seçilen tarihi _selected s listesine ekleyin
                              _selectedDates = [
                                selectedDay.toString().substring(0, 10)
                              ];
                            });
                          }
                        },
                        onRangeSelected: (start, end, focusedDay) {
                          // print("object");
                          setState(() {
                            // _selectedDay = null;
                            _focusedDay = focusedDay;
                            _rangeStart = start;
                            _rangeEnd = end;
                            _rangeSelectionMode = RangeSelectionMode.toggledOn;
                          });
                        },
                        onFormatChanged: (format) {
                          // print("dszf");
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          // print("sodkflşds");
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                NationalButton.nationalButton(
                  text: "Anket Oluştur",
                  onPressed: _createPoll,
                ),
                // NationalButton.nationalButton(
                //   text: "Seçilen Tarihler",
                //   onPressed: _saveSelectedDates,
                // ),
                // ElevatedButton(
                //   onPressed: _createPoll,
                //   child: const Text('Anket Oluştur'),
                // ),
                // const SizedBox(height: 20.0),
                // ElevatedButton(
                //   onPressed: _saveSelectedDates,
                //   child: const Text('Seçilen Tarihler'),
                // ),
                const SizedBox(height: 200.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveSelectedDates() {
    if (_selectedDates.isNotEmpty) {
      widget.onDatesSelected?.call(_selectedDates);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Seçilen tarihler kaydedildi: $_selectedDates'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${_rangeStart.toString().substring(0, 10)} , ${_rangeEnd.toString().substring(0, 10)}'),
        ),
      );
    }
  }
}
