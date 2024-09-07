import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voxpollui/class/custom/custom_createpoll.dart';
import 'package:voxpollui/class/model/custom_model/textfield_model.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class CreatePollPage extends StatefulWidget {
  final ValueChanged<List<String>>? onDatesSelected;
  const CreatePollPage({super.key, this.onDatesSelected});

  @override
  State<CreatePollPage> createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController firstOptionController = TextEditingController();
  List<FieldOption> _options = [
    FieldOption(),
    FieldOption(),
    FieldOption(),
    FieldOption()
  ];
  bool isFollowersOnly = false; // For the switch button

  void _addTextField() {
    if (_options.length >= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('En fazla 8 adet seçenek ekleyebilirsiniz.')),
      );
    } else {
      setState(() {
        _options.add(FieldOption());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = ['Siyaset', 'Ekonomi', 'Oyun'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black, // İkon rengi
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color.fromARGB(
                      255, 188, 188, 188),
                ),
                borderRadius:
                    BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Anket Oluştur",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Anket Başlığı
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset('assets/image/add_image.svg'),
                    onPressed: () {},
                  ),
                  labelText: "Anket Başlığı",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.nationalColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Seçenekler
              const Text(
                "Seçenekler",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Column(
                children: _options.asMap().entries.map((entry) {
                  final index = entry.key;
                  //final option = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: CustomTextField(
                      label: '${index + 1}.',
                      controller: firstOptionController,
                    ),
                  );
                }).toList(),
              ),
              /*
              TextField(
                      controller: option.controller,
                      decoration: InputDecoration(
                        labelText: '${index + 1}.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
              */
              const SizedBox(height: 10),

              // Seçenek Ekle Button
              Row(
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
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Kategori Dropdown
              const Text(
                'Kategori',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                value: options.first,
                onChanged: (String? newValue) {},
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(width: 10),
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Anket Süresi (Gün, Saat, Dakika)
              const Text(
                'Anket Süresi',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeField('Gün'),
                  _buildTimeField('Saat'),
                  _buildTimeField('Dakika'),
                ],
              ),
              const SizedBox(height: 20),

              // Takipçilere Özel Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Takipçilere Özel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Switch(
                    value: isFollowersOnly,
                    activeColor: AppColor.nationalColor,
                    onChanged: (bool value) {
                      setState(() {
                        isFollowersOnly = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Yayınla Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.nationalColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100.0,
                      vertical: 15.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Yayınla',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeField(String label) {
    return Flexible(
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
