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

static Future<bool> hasUserVoted(var pollData) async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    String userId = currentUser?.objectId ?? "BilinmeyenKullanıcı";
    String pollId = pollData['poll'].objectId;

    QueryBuilder<ParseObject> queryUserPollResponse = QueryBuilder<ParseObject>(ParseObject('PollResponse'))
      ..whereEqualTo('userId', userId)
      ..whereEqualTo('pollId', pollId);

    final ParseResponse apiResponse = await queryUserPollResponse.query();

    if (apiResponse.success && apiResponse.results != null && apiResponse.results!.isNotEmpty) {
      // Kullanıcı bu ankette daha önce oy kullanmış
      return true;
    } else {
      // Kullanıcı bu ankette daha önce oy kullanmamış
      return false;
    }
  }

  static Future<int> countUserPollResponses(String userId) async {
    try {
      final ParseCloudFunction function = ParseCloudFunction('countUserPollResponses');
      final Map<String, dynamic> params = <String, dynamic>{
        'userId': userId,
      };
      final ParseResponse result = await function.execute(parameters: params);

      if (result.success && result.result != null) {
        print('Başarılı ${result.result}');
        return result.result;
      } else {
        print('Cloud fonksiyonu çağrılırken hata oluştu');
        return 3;
      }
    } catch (e) {
      print('Bir hata oluştu: $e');
      return 3;
    }
  }

  /*  Future<List<PollOption>> _fetchPollOptions() async {
    var poll = widget.pollData['poll'];
    String pollId = poll?.get<String>('objectId') ?? 'Bilinmiyor';
    QueryBuilder<ParseObject> queryPollOptions = QueryBuilder<ParseObject>(ParseObject('PollOption'))
      ..whereEqualTo('pollId', pollId);

    final ParseResponse apiResponse = await queryPollOptions.query();

    if (apiResponse.success && apiResponse.results != null) {
      _pollOptionTitles.clear(); // Listeyi temizleyin
      return apiResponse.results!.map((e) {
        String optionId = e.get<String>('objectId') ?? 'Bilinmiyor';
        String optionTitle = e.get<String>('text') ?? 'Hata';
        _pollOptionTitles.add(optionTitle); // Başlığı listeye ekleyin
        return PollOption(
          id: optionId,
          title: Text(optionTitle),
          votes: e.get<int>('votes') ?? 0,
        );
      }).toList();
    } else {
      return [];
    }
  }*/

  static Future<int> fetchPollResponseCount(String pollId) async {
    final ParseCloudFunction function = ParseCloudFunction('countPollResponses');
    final Map<String, dynamic> params = <String, dynamic>{
      'pollId': pollId,
    };
    final ParseResponse result = await function.execute(parameters: params);

    if (result.success && result.result != null) {
      print('${result.result}  RESULTS RESULTS');
      return result.result as int;
    } else {
      return 0;
    }
  }
}