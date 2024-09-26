import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class UploadService extends BaseService {
  factory UploadService() => _instance;
  UploadService._();
  static final UploadService _instance = UploadService._();

  Future<String> uploadImage({
    required XFile file,
    required UploadFolder folder,
  }) async {
    final ref = storage.ref().child(folder.name).child(file.name);
    final uploadTask = ref.putFile(File(file.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    print(url);
    return url;
  }
}

enum UploadFolder {
  communityImage,
  userImage,
}