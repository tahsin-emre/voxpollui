import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Database {
  Future<List<Map<String, dynamic>>> fetchPolls() async {
  final queryForPoll = QueryBuilder(ParseObject('Poll'));
  final queryForPollOption = QueryBuilder(ParseObject('PollOption'));
  final responseForPoll = await queryForPoll.query();
  final responseForPollOption = await queryForPollOption.query();

  if (responseForPoll.success && responseForPoll.results != null) {
    if (responseForPollOption.success && responseForPollOption.result != null) {
      List<Map<String, dynamic>> combinedResults = [];
      for (var poll in responseForPoll.results as List<ParseObject>) {
        var createdBy = poll.get<String>('createdBy');
        var creatorData = await fetchCreater(createdBy);
        combinedResults.add({
          'poll': poll,
          'creator': creatorData,
        });
      }
      for (var pollOption in responseForPollOption.results as List<ParseObject>) {
        combinedResults.add({
          'pollOption': pollOption,
        });
      }
      return combinedResults;
    } else {
      return [];
    }
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