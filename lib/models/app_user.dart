class AppUser {
  final String uid;
  final String name;

  AppUser({
    this.uid = '',
    this.name = '',
  });

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'name': name,
    };
  }

  static AppUser fromJSON(json) {
    return AppUser(
      uid: json['uid'] as String,
      name: json['name'] as String,
    );
  }

  AppUser copy({
    String? uid,
    String? name,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        name: name ?? this.name,
      );
}
