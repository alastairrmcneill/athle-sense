import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class ResponseDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create

  // Read
  static readEventResponses(ResponseNotifier responseNotifier, String eventUid) async {
    List<Response> _responseList = [];
    List<List<Response>> _responsePerDayList = [[]];

    Query eventResponseQuery = _db.collection('Responses').where('eventUid', isEqualTo: eventUid);

    await eventResponseQuery.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Response newResponse = Response.fromJSON(doc);
        _responseList.add(newResponse);
        print(newResponse.date);
      });
    });

    // Sort list
    _responseList.sort((a, b) => a.date.compareTo(b.date));

    _responseList.forEach((element) {
      print(element.date);
    });

    responseNotifier.setAllResponses = _responseList;
  }

  // Update

  // Delete

}
