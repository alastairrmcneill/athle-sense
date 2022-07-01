class AppUser {
  final String uid;
  final String name;
  final String email;

  AppUser({
    this.uid = '',
    this.name = '',
    this.email = '',
  });

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  static AppUser fromJSON(json) {
    return AppUser(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  AppUser copy({
    String? uid,
    String? name,
    String? email,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
      );
}
