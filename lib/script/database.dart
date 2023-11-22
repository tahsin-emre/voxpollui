import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Database {
  Future<List<Map<String, dynamic>>> fetchPolls() async {
  final queryForPoll = QueryBuilder(ParseObject('Poll'));
  final responseForPoll = await queryForPoll.query();

  if (responseForPoll.success && responseForPoll.results != null) {
    List<Map<String, dynamic>> combinedResults = [];
    for (var poll in responseForPoll.results as List<ParseObject>) {
      var createdBy = poll.get<String>('createdBy');
      ParseObject? creatorData;
      if (createdBy != null && createdBy.isNotEmpty) {
        creatorData = await fetchCreater(createdBy);
      }
      combinedResults.add({
          'poll': poll,
          'creator': creatorData,
      });
    }
    print('$combinedResults    COOOMMMBİİİNEEEDDDRESSUUULLLTSSS');
    return combinedResults;
  } else {
    // Hata durumunda işlem
    return [];
  }
}



Future<ParseObject?> fetchCreater(String? createrId) async {
  if (createrId == null) return null;

  final query = QueryBuilder(ParseObject('_User'))
    ..whereEqualTo('objectId', createrId);
  final response = await query.query();

  if (response.success && response.results != null) {
    return response.results?.first as ParseObject?;
  } else {
    // Hata durumunda işlem
    return null;
  }
}
}