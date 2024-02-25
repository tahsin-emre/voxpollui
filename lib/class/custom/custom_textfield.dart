import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class PollTextField {
  static Future<dynamic> _openGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      return imageFile;
    } else {
      return Text('Resim seçilmedi');
    }
  }

  static Widget pollTextField({
    required TextEditingController controller,
    required BuildContext context,
    required String labelText,
  }) {
    var dosyaYolu;
    return Row(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                dosyaYolu = _openGallery();
              },
              child: Icon(Icons.add_box, color: AppColor.nationalColor),
            ),
            label: Text(
              labelText,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Image.file(dosyaYolu ?? File('null')),
      ],
    );
  }
}
