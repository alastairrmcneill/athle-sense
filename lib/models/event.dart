import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? uid;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> admins;
  final List<String> members;

  Event({
    this.uid,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.admins,
    required this.members,
  });

  // From JSON
  Event fromJSON(json) {
    return Event(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      admins: List<String>.from(json['admins']),
      members: List<String>.from(json['members']),
    );
  }

  // To JSON
  Map<String, Object> toJSON() {
    return {
      'uid': uid!,
      'name': name,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'admins': admins,
      'members': members,
    };
  }

  // Copy
  Event copy({
    String? uid,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? admins,
    List<String>? members,
  }) =>
      Event(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        admins: admins ?? this.admins,
        members: members ?? this.members,
      );
}
