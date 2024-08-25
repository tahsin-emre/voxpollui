import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class BirthDateSelector extends StatefulWidget {
  final Function(DateTime?)? onDateSelected;
  final DateTime? initialDate;
  final String hintText;

  BirthDateSelector({
    Key? key,
    this.onDateSelected,
    this.initialDate,
    this.hintText = 'Doğum Tarihi',
  }) : super(key: key);

  @override
  _BirthDateSelectorState createState() => _BirthDateSelectorState();
}

class _BirthDateSelectorState extends State<BirthDateSelector> {
  late TextEditingController _birthDateController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _birthDateController = TextEditingController();
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate;
      _birthDateController.text = _formatDate(_selectedDate!);
    }
  }

  @override
  void dispose() {
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    // Özelleştirilmiş tarih seçici
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.nationalColor, // Ana renk olarak nationalColor kullanılır
              onPrimary: Colors.white, // Başlık yazısı rengi
              onSurface: Colors.black, // Seçilebilir öğelerin yazı rengi
            ),
            dialogBackgroundColor: Colors.white, // Arka plan rengi
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _birthDateController.text = _formatDate(pickedDate);
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(pickedDate);
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _birthDateController.text.isEmpty ? widget.hintText : _birthDateController.text,
              style: TextStyle(
                color: _birthDateController.text.isEmpty ? Colors.grey : Colors.black,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: AppColor.nationalColor,
            ),
          ],
        ),
      ),
    );
  }
}
