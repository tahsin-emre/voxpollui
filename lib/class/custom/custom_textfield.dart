import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PollTextField {
  static File? _selectedImage;

  static Future<void> _openGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      // Ekranı yenilemek için
      (context as Element).markNeedsBuild();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resim seçilmedi')),
      );
    }
  }

  static Widget pollTextField({
    required TextEditingController controller,
    required BuildContext context,
    required String labelText,
  }) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => _openGallery(context),
              child: Icon(Icons.add_photo_alternate, color: Colors.blue),
            ),
            label: Text(labelText),
          ),
        ),
        if (_selectedImage != null) // Görseli göster
          Image.file(_selectedImage!),
      ],
    );
  }
}
