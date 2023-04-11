import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class ResponseDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _responseRef = _db.collection('responses');

  // Create
  static Future create(BuildContext context, {required Response response}) async {
    try {
      DocumentReference _ref = _responseRef.doc();

      Response newResponse = response.copy(uid: _ref.id);

      await _ref.set(newResponse.toJSON());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message ?? 'There was an error storing your response.');
    }
  }

  // Read
  static Future<List<Response>> readMyResponses(BuildContext context) async {
    Query query = _responseRef
        .where(
          'userUid',
          isEqualTo: AuthService.currentUserId!,
        )
        .orderBy(
          'date',
          descending: false,
        );
    QuerySnapshot querySnapshot = await query.get();

    List<Response> responseList = [];

    for (var doc in querySnapshot.docs) {
      Response response = Response.fromJSON(doc.data());
      responseList.add(response);
    }

    return responseList;
  }

  static Future readEventResponses(ResponseNotifier responseNotifier, String eventUid) async {
    List<Response> _responseList = [];
    List<List<Response>> _responsePerDayList = [[]];

    Query eventResponseQuery = _db.collection('Responses').where('eventUid', isEqualTo: eventUid);

    await eventResponseQuery.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Response newResponse = Response.fromJSON(doc);
        _responseList.add(newResponse);
      });
    });

    // Sort list
    _responseList.sort((a, b) => a.date.compareTo(b.date));

    // Split into days

    for (var response in _responseList) {
      if (_responsePerDayList[0].isEmpty) {
        _responsePerDayList[0].add(response);
      } else {
        if (response.date.isAfter(_responsePerDayList.last[0].date)) {
          _responsePerDayList.add([response]);
        } else {
          _responsePerDayList.last.add(response);
        }
      }
    }

    // Write to notifiers
    responseNotifier.setAllResponses = _responseList;
    responseNotifier.setResponseEachDay = _responsePerDayList;
  }

  static Future<List<Response>> readEventMemberResponses(BuildContext context, {required List<String> allMemberUIDs}) async {
    List<Response> _responseList = [];
    var chunks = [];
    int chunkSize = 5;
    for (var i = 0; i < allMemberUIDs.length; i += chunkSize) {
      chunks.add(allMemberUIDs.sublist(i, i + chunkSize > allMemberUIDs.length ? allMemberUIDs.length : i + chunkSize));
    }

    Timestamp startDate = Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 28)));
    for (var chunk in chunks) {
      Query query = _responseRef
          .where(
            'date',
            isGreaterThan: startDate,
          )
          .orderBy(
            'date',
            descending: false,
          )
          .where(
            'userUid',
            whereIn: chunk,
          );

      QuerySnapshot querySnapshot = await query.get();

      for (var doc in querySnapshot.docs) {
        Response response = Response.fromJSON(doc.data());
        _responseList.add(response);
      }
    }

    return _responseList;
  }

  static Future<List<Response>> readMemberResponses(BuildContext context, {required String userUid}) async {
    List<Response> _responseList = [];

    Query query = _responseRef
        .where(
          'userUid',
          isEqualTo: userUid,
        )
        .orderBy(
          'date',
          descending: false,
        )
        .limit(
          28,
        );

    QuerySnapshot querySnapshot = await query.get();

    for (var doc in querySnapshot.docs) {
      Response response = Response.fromJSON(doc.data());
      _responseList.add(response);
    }

    return _responseList;
  }

  // Delete
  static Future deleteUserResponses(BuildContext context, {required String uid}) async {
    try {
      await _db.collection('responses').where('userUid', isEqualTo: uid).get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message ?? 'There was an issue removing your previous responses.');
    }
  }
}
