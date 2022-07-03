import 'package:cloud_firestore/cloud_firestore.dart';

class Response {
  final String? uid;
  final String userUid;
  final String eventUid;
  final DateTime date;

  Response({
    required this.uid,
    required this.userUid,
    required this.eventUid,
    required this.date,
  });

  // From JSON
  static fromJSON(json) {
    return Response(
      uid: json['uid'] as String?,
      userUid: json['userUid'] as String,
      eventUid: json['eventUid'] as String,
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  // To JSON
  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'userUid': userUid,
      'eventUid': eventUid,
      'date': date,
    };
  }

  // Copy
  Response copy({
    String? uid,
    String? userUid,
    String? eventUid,
    DateTime? date,
  }) =>
      Response(
        uid: uid ?? this.uid,
        userUid: userUid ?? this.userUid,
        eventUid: eventUid ?? this.eventUid,
        date: date ?? this.date,
      );
}
