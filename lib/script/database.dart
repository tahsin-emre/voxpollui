import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/class/model/user.dart';

class Database {
  
  Future<Map<String, dynamic>> fetchPolls() async {
    try {
      final ParseCloudFunction function = ParseCloudFunction('getPollAndUserDetails');
      final ParseResponse result = await function.execute();

      if (result.success && result.result != null) {
        Map<String, dynamic> data = result.result;

        // İsterseniz burada gelen veriler üzerinde daha fazla işlem yapabilirsiniz
        // Örneğin, kullanıcıların ve anketlerin listesini alabilirsiniz:
        //   List<Map<String, dynamic>> allUsersData = List<Map<String, dynamic>>.from(data['users']);
        //   List<Map<String, dynamic>> allPollsData = List<Map<String, dynamic>>.from(data['polls']);

        //   print('Tüm kullanıcılar: ${allUsersData[0]['username']}');
        //  print('Tüm anketler: $allPollsData');

        return data;
      } else {
        throw Exception('Sunucu tarafında bir hata oluştu.');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }


  Future<CreatorData?> fetchCreater(String createrId) async {
    // print()
    try {
      final ParseCloudFunction function = ParseCloudFunction('getUserById');
      final Map<String, dynamic> params = <String, dynamic>{'userId': createrId};
      final ParseResponse result = await function.execute(parameters: params);
      // print(result.success);
      // print(result.error);
      // print(result.result);
      if (result.success) {
        if (result.result != null) {
          Map<String, dynamic> data = result.result;
          CreatorData creator = CreatorData.fromJson(data);
          return creator;
        } else {
          return null; // Sonuç yoksa null döndür
        }
      } else {
        throw Exception(result.error);
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }




  static Future<bool> hasUserVoted(List<Map<dynamic, dynamic>> pollData, int index) async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    String userId = currentUser?.objectId ?? "BilinmeyenKullanıcı";
    String pollId = pollData[index]['objectId'];

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
        // print('Başarılı ${result.result}');
        return result.result;
      } else {
        throw Exception('Cloud fonksiyonu çağrılırken hata oluştu');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }
}