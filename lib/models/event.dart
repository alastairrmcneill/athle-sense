class Event {
  final String? uid;
  final String name;
  final List<String> admins;
  final List<String> members;

  Event({
    this.uid,
    required this.name,
    required this.admins,
    required this.members,
  });

  // From JSON
  Event fromJSON(json) {
    return Event(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      admins: List<String>.from(json['admins']),
      members: List<String>.from(json['members']),
    );
  }

  // To JSON
  Map<String, Object> toJSON() {
    return {
      'uid': uid!,
      'name': name,
      'admins': admins,
      'members': members,
    };
  }

  // Copy
  Event copy({
    String? uid,
    String? name,
    List<String>? admins,
    List<String>? members,
  }) =>
      Event(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        admins: admins ?? this.admins,
        members: members ?? this.members,
      );
}
