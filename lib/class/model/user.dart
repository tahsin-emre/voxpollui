class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  List<Map<String, dynamic>>? polls;
  List<Map<String, dynamic>>? users;
  List<Map<String, dynamic>>? comm;

Future<void> setCombinedResults(Map<dynamic, dynamic> results) async {
  // print('RESULTS   $results');
      polls = List<Map<String, dynamic>>.from(results['polls']);
      // print('POLLS $polls');
      users = List<Map<String, dynamic>>.from(results['users']);
      // print('CREATORS $creators');
      comm = List<Map<String, dynamic>>.from(results['comm']);
}


List<Map<String, dynamic>>? getPolls() {
  // print('GET POLLS POLLS   $polls');
  return polls;
}

List<Map<String, dynamic>>? getUsers() {
  return users;
}

List<Map<String, dynamic>>? getComm() {
  return comm;
}

}



class Poll {
  final String objectId;
  final String title;
  final String createdBy;
  final int totalParticipants;
  final String deletedDate;

  Poll({
    required this.objectId,
    required this.title,
    required this.createdBy,
    required this.totalParticipants,
    required this.deletedDate,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      objectId: json['objectId'] as String,
      title: json['title'] as String,
      createdBy: json['createdBy'] as String,
      totalParticipants: json['totalParticipants'] as int,
      deletedDate: json['deletedDate'] as String,
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
  final List<dynamic> interests;
  final String biography;
  final bool emailVerified;
  final List<dynamic> followed;
  final List<dynamic> followers;
  final String profileImageUrl;

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
    required this.profileImageUrl,
  });
  factory CreatorData.fromJson(Map<String, dynamic> json) {
    return CreatorData(
      objectId: json['objectId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      birthDate: json['birthDate'] as String? ?? '',
      city: json['city'] as String? ?? '',
      district: json['district'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      interests: List<String>.from(json['interests'] as List<dynamic>? ?? []),
      biography: json['biography'] as String? ?? '',
      emailVerified: json['emailVerified'] as bool? ?? false,
      followed: List<String>.from(json['followed'] as List<dynamic>? ?? []),
      followers: List<String>.from(json['followers'] as List<dynamic>? ?? []),
      profileImageUrl: json['profile_photo'] as String? ?? 'https://parsefiles.back4app.com/WRA6Rjonj88lwnpOJU1jTLt7pZXl0dFRNVIyMCqH/2e730d269c30302bd4d5ce48826f0073_default_profile_foto.png',
    );
  }
}