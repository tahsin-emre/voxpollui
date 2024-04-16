import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ChooseProfilePage extends StatefulWidget {
  const ChooseProfilePage({super.key});

  @override
  State<ChooseProfilePage> createState() => _ChooseProfilePageState();
}

class _ChooseProfilePageState extends State<ChooseProfilePage> {

  String photo_url = "https://parsefiles.back4app.com/WRA6Rjonj88lwnpOJU1jTLt7pZXl0dFRNVIyMCqH/2e730d269c30302bd4d5ce48826f0073_default_profile_foto.png";

  File? photo_file;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        photo_file = File(pickedFile.path);
      });
      uploadImageFile(photo_file!);
    }
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text(
              'Choose Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Image.network(photo_url),
            )
          ],
        )
      ),
    );
  }
}