import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/national/get_font.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items; // Dışarıdan alınacak dropdown öğeleri

  const CustomDropdown({required this.items, Key? key}) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue; // Başlangıç değeri

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.isNotEmpty ? widget.items.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.search, color: Colors.black),
            ),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  isExpanded: true,
                  icon: const SizedBox.shrink(),
                  items: widget.items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: GetFont.GILROY_LIGHT,
                  ),
                  dropdownColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
