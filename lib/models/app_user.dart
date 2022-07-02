class AppUser {
  final String uid;
  final String name;
  final String email;
  late List<String> events = [];

  AppUser({
    this.uid = '',
    this.name = '',
    this.email = '',
    required this.events,
  });

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'events': events,
    };
  }

  static AppUser fromJSON(json) {
    return AppUser(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      events: List<String>.from(json['events']),
    );
  }

  AppUser copy({
    String? uid,
    String? name,
    String? email,
    List<String>? events,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        events: events ?? this.events,
      );
}
