import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';


class Database {
  Future<List<Map<String, dynamic>>> fetchPolls(String pollId, String userId) async {
    final ParseCloudFunction function = ParseCloudFunction('getPollAndUserDetails');
    final Map<String, dynamic> params = <String, dynamic>{
      'pollId': pollId,
      'userId': userId,
    };
    final ParseResponse result = await function.execute(parameters: params);

    if (result.success && result.result != null) {
      print('${result.result}  RESULTS RESULTS');
      return result.results as List<Map<String, dynamic>>;
    } else {
      return [{}];
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

//   static Future<List<Map<String, dynamic>>> fetchPollResponseCount(String pollId, String userId) async {
//     final ParseCloudFunction function = ParseCloudFunction('getPollAndUserDetails');
//     final Map<String, dynamic> params = <String, dynamic>{
//       'pollId': pollId,
//       'userId': userId,
//     };
//     final ParseResponse result = await function.execute(parameters: params);

//     if (result.success && result.result != null) {
//       print('${result.result}  RESULTS RESULTS');
//       return result.results as List<Map<String, dynamic>>;
//     } else {
//       return [{}];
//     }
//   }
// }