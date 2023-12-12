class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  List<Map<String, dynamic>> combinedResults = [];

  void setCombinedResults(List<Map<String, dynamic>> results) {
    combinedResults = results;
  }

  List<Map<String, dynamic>> getCombinedResults() {
    return combinedResults;
  }

  // Ek fonksiyonlar
  List<Poll> getPolls() {
    return combinedResults.map((result) {
      return Poll.fromJson(result['poll']);
    }).toList();
  }

  List<CreatorData> getCreators() {
    return combinedResults.map((result) {
      return CreatorData.fromJson(result['creator']);
    }).toList();
  }
}


class Poll {
  final String objectId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String createdBy;
  final CreatorData creator;

  Poll({
    required this.objectId,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.createdBy,
    required this.creator,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      objectId: json['objectId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String,
      createdBy: json['createdBy'] as String,
      creator: CreatorData.fromJson(json['creator'] as Map<String, dynamic>),
    );
  }
}

class CreatorData {
  final String objectId;
  final DateTime createdAt;
  final DateTime updatedAt;
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

  CreatorData({
    required this.objectId,
    required this.createdAt,
    required this.updatedAt,
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
  });

  factory CreatorData.fromJson(Map<String, dynamic> json) {
    return CreatorData(
      objectId: json['objectId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
    );
  }
}
