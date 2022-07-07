import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class ResponseDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  static Future<bool> createResponse(ResponseNotifier responseNotifier, Response response) async {
    bool _success = false;
    DocumentReference _ref = _db.collection('Responses').doc();

    Response newResponse = response.copy(uid: _ref.id);
    try {
      await _ref.set(newResponse.toJSON()).whenComplete(() => _success = true);
    } on FirebaseException catch (error) {
      _success = false;
    }
    return _success;
  }

  // Read
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

  // Update

  // Delete

}
