import 'package:flutter/material.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class PollTextField {
  static TextField pollTextField({
    required TextEditingController titleController,
    required BuildContext context,
  }) {
    return TextField(
      controller: titleController,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Kullanıcının galerisi açılacak"),
                );
              }
            );
          },
          child: Icon(Icons.add_box, color: AppColor.nationalColor),
        ),
        label: const Text(
          'Anket Başlığı',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
