import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SearchClass {
  static Future<ParseObject> searchData(
    String searchText,
    {
      String? className,
      required String columnName,
    }
  ) async {
    final queryBuilder = QueryBuilder(
      className!.isEmpty ? ParseUser.forQuery() : ParseObject(className),
    )..whereContains(columnName, searchText); // Aranacak metin

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      final results = response.results;
      for (final object in results ?? []) {
        ParseObject poll = object as ParseObject;
        return poll;
      }
      // Döngüden çıkıldığında bir değer döndürmediği için hata fırlatılabilir.
      throw Exception('No object found matching the search criteria.');
    } else {
      // Hata durumunda bir istisna fırlatılmalıdır.
      throw Exception('Error while searching: ${response.error!.message}');
    }
  }
}
