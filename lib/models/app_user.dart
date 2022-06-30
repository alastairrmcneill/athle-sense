class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;

  AppUser({
    this.uid = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  });

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  static AppUser fromJSON(json) {
    List<dynamic> households = json['households'];
    List<String> newHouseholds = List<String>.from(households);

    return AppUser(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
    );
  }

  AppUser copy({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    List<String>? households,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
      );
}
