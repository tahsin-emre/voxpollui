import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voxpollui/class/model/national/get_color.dart';

class PollTextField {
  static Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    // Kullanıcı bir resim seçtiyse, seçilen resmin dosya yolu pickedImage.path olacak
    if (pickedImage != null) {
      // Seçilen resmi işleyin (örneğin, yükleyin veya görüntüleyin)
    }
  }
  static TextField pollTextField({
    required TextEditingController controller,
    required BuildContext context,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            _openGallery();
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
    );
  }
}
