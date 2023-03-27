import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? uid;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String creator;
  final List<String> admins;
  final List<String> members;
  final bool amAdmin;
  final String shareId;
  final int notificationId;

  Event({
    this.uid,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.creator,
    required this.admins,
    required this.members,
    this.amAdmin = false,
    required this.shareId,
    required this.notificationId,
  });

  // From JSON
  static Event fromJSON(json) {
    return Event(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      creator: json['creator'] as String,
      admins: List<String>.from(json['admins']),
      members: List<String>.from(json['members']),
      shareId: json['shareId'] as String,
      notificationId: json['notificationId'] as int,
    );
  }

  // To JSON
  Map<String, Object> toJSON() {
    return {
      'uid': uid!,
      'name': name,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'creator': creator,
      'admins': admins,
      'members': members,
      'shareId': shareId,
      'notificationId': notificationId,
    };
  }

  // Copy
  Event copy({
    String? uid,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? creator,
    List<String>? admins,
    List<String>? members,
    bool? amAdmin,
    String? shareId,
    int? notificationId,
  }) =>
      Event(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        creator: creator ?? this.creator,
        admins: admins ?? this.admins,
        members: members ?? this.members,
        amAdmin: amAdmin ?? this.amAdmin,
        shareId: shareId ?? this.shareId,
        notificationId: notificationId ?? this.notificationId,
      );
}
