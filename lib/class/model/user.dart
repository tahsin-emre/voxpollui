class User {
    String objectId;
    bool emailVerified;
    String name;
    String username;
    String surname;
    String birthDate;
    String city;
    String district;
    String gender;
    List<String> interests;
    String biography;
    String email;
    DateTime createdAt;
    DateTime updatedAt;
    List<String> followed;
    List<String> followers;
    String password;

    User({
        required this.objectId,
        required this.emailVerified,
        required this.name,
        required this.username,
        required this.surname,
        required this.birthDate,
        required this.city,
        required this.district,
        required this.gender,
        required this.interests,
        required this.biography,
        required this.email,
        required this.createdAt,
        required this.updatedAt,
        required this.followed,
        required this.followers,
        required this.password,
    });

    User copyWith({
        String? objectId,
        bool? emailVerified,
        String? name,
        String? username,
        String? surname,
        String? birthDate,
        String? city,
        String? district,
        String? gender,
        List<String>? interests,
        String? biography,
        String? email,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<String>? followed,
        List<String>? followers,
        String? password,
    }) => 
        User(
            objectId: objectId ?? this.objectId,
            emailVerified: emailVerified ?? this.emailVerified,
            name: name ?? this.name,
            username: username ?? this.username,
            surname: surname ?? this.surname,
            birthDate: birthDate ?? this.birthDate,
            city: city ?? this.city,
            district: district ?? this.district,
            gender: gender ?? this.gender,
            interests: interests ?? this.interests,
            biography: biography ?? this.biography,
            email: email ?? this.email,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            followed: followed ?? this.followed,
            followers: followers ?? this.followers,
            password: password ?? this.password,
        );
}
