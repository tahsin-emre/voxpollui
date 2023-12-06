import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
class CustomParseUser extends ParseUser {
  CustomParseUser(String? username, String? password, String? emailAddress)
      : super(username, password, emailAddress);

      

  Future<int> countUserPollResponses() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    // Burada, kullanıcının katıldığı anket sayısını hesaplayan kodu yazın
    // Örnek olarak, bu fonksiyon her zaman 0 döndürecek şekilde ayarlanmıştır
    return 0;
  }
}
