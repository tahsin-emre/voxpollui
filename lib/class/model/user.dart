class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  List<Map<String, dynamic>>? polls;
  List<Map<String, dynamic>>? creators;

Future<void> setCombinedResults(Map<dynamic, dynamic> results) async {
  // print('RESULTS   $results');
      polls = List<Map<String, dynamic>>.from(results['polls']);
      // print('POLLS $polls');
      creators = List<Map<String, dynamic>>.from(results['users']);
      // print('CREATORS $creators');
}




List<Map<String, dynamic>>? getPolls() {
  // print('GET POLLS POLLS   $polls');
  return polls;
}

List<Map<String, dynamic>>? getCreators() {
  return creators;
}

}



class Poll {
  final String objectId;
  final String title;
  final String createdBy;
  final int totalParticipants;

  Poll({
    required this.objectId,
    required this.title,
    required this.createdBy,
    required this.totalParticipants,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      objectId: json['objectId'] as String,
      title: json['title'] as String,
      createdBy: json['createdBy'] as String,
      totalParticipants: json['totalParticipants'] as int,
    );
  }
}

class CreatorData {
  final String objectId;
  final String username;
  final String name;
  final String surname;
  final String birthDate;
  final String city;
  final String district;
  final String gender;
  final List<String> interests;
  final String biography;
  final bool emailVerified;
  final List<String> followed;
  final List<String> followers;

  CreatorData({
    required this.objectId,
    required this.username,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.city,
    required this.district,
    required this.gender,
    required this.interests,
    required this.biography,
    required this.emailVerified,
    required this.followed,
    required this.followers,
  });

  factory CreatorData.fromJson(Map<String, dynamic> json) {
    return CreatorData(
      objectId: json['objectId'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      birthDate: json['birthDate'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      gender: json['gender'] as String,
      interests: List<String>.from(json['interests'] as List),
      biography: json['biography'] as String,
      emailVerified: json['emailVerified'] as bool,
      followed: json['followed'] as List<String>,
      followers: json['followers'] as List<String>,
    );
  }
}
