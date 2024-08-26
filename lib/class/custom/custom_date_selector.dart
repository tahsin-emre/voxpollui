import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

// ignore: must_be_immutable
class BirthDateSelector extends StatefulWidget {
  final Function(DateTime?)? onDateSelected;
  final DateTime? initialDate;
  late TextEditingController? birthDateController;
  final String hintText;

  BirthDateSelector({
    Key? key,
    this.onDateSelected,
    this.initialDate,
    this.birthDateController,
    this.hintText = 'Doğum Tarihi',
  }) : super(key: key);

  @override
  _BirthDateSelectorState createState() => _BirthDateSelectorState();
}

class _BirthDateSelectorState extends State<BirthDateSelector> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    widget.birthDateController = TextEditingController();
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate;
      widget.birthDateController!.text = _formatDate(_selectedDate!);
    }
  }

  @override
  void dispose() {
    widget.birthDateController!.dispose();
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
        widget.birthDateController!.text = _formatDate(pickedDate);
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
              widget.birthDateController!.text.isEmpty ? widget.hintText : widget.birthDateController!.text,
              style: TextStyle(
                color: widget.birthDateController!.text.isEmpty ? Colors.grey : Colors.black,
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
