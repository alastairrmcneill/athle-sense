import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class ResponseDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _responseRef = _db.collection('responses');

  // Create
  static Future<bool> createResponse(BuildContext context, {required Response response}) async {
    bool _success = false;
    DocumentReference _ref = _responseRef.doc();

    Response newResponse = response.copy(uid: _ref.id);

    try {
      await _ref.set(newResponse.toJSON()).whenComplete(() {
        _success = true;
      });
    } on FirebaseException catch (error) {
      _success = false;
    }
    return _success;
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

  // Update
  static Future deleteEventResponses(String eventUid, String userUid) async {
    await _db.collection('Responses').where('userUid', isEqualTo: userUid).where('eventUid', isEqualTo: eventUid).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  // Delete

  static Future deleteUserResponses(String uid) async {
    await _db.collection('Responses').where('userUid', isEqualTo: uid).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
