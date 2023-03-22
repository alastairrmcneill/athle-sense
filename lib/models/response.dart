import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellness_tracker/support/theme.dart';

class Response {
  final String? uid;
  final String userUid;
  final String? eventUid;
  final DateTime date;
  final List<int> ratings;
  final int wellnessRating;
  final int availability;

  Response({
    this.uid,
    required this.userUid,
    this.eventUid,
    required this.date,
    required this.ratings,
    required this.wellnessRating,
    required this.availability,
  });

  // From JSON
  static fromJSON(json) {
    return Response(
      uid: json['uid'] as String?,
      userUid: json['userUid'] as String,
      eventUid: json['eventUid'] as String?,
      date: (json['date'] as Timestamp).toDate(),
      ratings: List<int>.from(json['ratings']),
      wellnessRating: json['wellnessRating'] as int,
      availability: json['availability'] as int,
    );
  }

  // To JSON
  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'userUid': userUid,
      'eventUid': eventUid,
      'date': date,
      'ratings': ratings,
      'wellnessRating': wellnessRating,
      'availability': availability,
    };
  }

  // Copy
  Response copy({
    String? uid,
    String? userUid,
    String? eventUid,
    DateTime? date,
    List<int>? ratings,
    int? wellnessRating,
    int? availability,
  }) =>
      Response(
        uid: uid ?? this.uid,
        userUid: userUid ?? this.userUid,
        eventUid: eventUid ?? this.eventUid,
        date: date ?? this.date,
        ratings: ratings ?? this.ratings,
        wellnessRating: wellnessRating ?? this.wellnessRating,
        availability: availability ?? this.availability,
      );

  static List<Icon> availabilityIcons = [
    Icon(
      FontAwesomeIcons.solidFaceFrown,
      color: MyColors.darkRedColor,
    ),
    Icon(
      FontAwesomeIcons.solidFaceMeh,
      color: MyColors.darkYellowColor,
    ),
    Icon(
      FontAwesomeIcons.solidFaceGrin,
      color: MyColors.darkGreenColor,
    ),
  ];
}
