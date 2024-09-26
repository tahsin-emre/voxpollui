import 'dart:io';

import 'package:voxpollui/product/services/firebase/base_service.dart';

final class UploadService extends BaseService {
  factory UploadService() => _instance;
  UploadService._();
  static final UploadService _instance = UploadService._();

  Future<String> uploadImage(String path, String fileName, File file) async {
    final ref = storage.ref().child(path).child(fileName);
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
