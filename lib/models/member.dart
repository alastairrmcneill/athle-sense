class Member {
  final String uid;
  final String name;

  Member({
    required this.uid,
    required this.name,
  });

  // From JSON
  static Member fromJSON(json) {
    return Member(
      uid: json['uid'] as String,
      name: json['name'] as String,
    );
  }

  // To JSON
  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'name': name,
    };
  }

  // Copy
  Member copy({
    String? uid,
    String? name,
  }) =>
      Member(
        uid: uid ?? this.uid,
        name: name ?? this.name,
      );
}
