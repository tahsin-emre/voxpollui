import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:voxpollui/class/custom/custom_textfield.dart';
import 'package:voxpollui/class/model/national/get_color.dart';
import 'package:voxpollui/class/utils.dart';
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

    List<DateTime> _selectedDates = [];
    CalendarFormat _calendarFormat = CalendarFormat.month;
    RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn; // Can be toggled on/off by longpressing a date
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;
    DateTime? _rangeStart;
    DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    // String selectedValue = 'Seçenek 1';
    List<String> options = ['Seçenek 1', 'Seçenek 2', 'Seçenek 3'];
    return Scaffold(
      appBar: AppBar(),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      width: MediaQuery.of(context).size.width -50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(3, 3), // changes position of shadow
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
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              _rangeStart = null; // Important to clean those
                              _rangeEnd = null;
                              _rangeSelectionMode = RangeSelectionMode.toggledOff;
                              // Seçilen tarihi _selectedDates listesine ekleyin
                              _selectedDates = [selectedDay];
                            });
                          }
                        },
                        onRangeSelected: (start, end, focusedDay) {
                          setState(() {
                            // _selectedDay = null;
                            _focusedDay = focusedDay;
                            _rangeStart = start;
                            _rangeEnd = end;
                            _rangeSelectionMode = RangeSelectionMode.toggledOn;
                          });
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _createPoll,
                  child: const Text('Anket Oluştur'),
                ),
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
      // widget.onDatesSelected?.call(_selectedDates);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Seçilen tarihler kaydedildi: $_selectedDates'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Henüz hiçbir tarih seçilmedi!'),
        ),
      );
    }
  }
}
