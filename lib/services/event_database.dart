import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/services/services.dart';

class EventDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _eventsRef = _db.collection('events');

  // Create
  static Future create(BuildContext context, {required Event event}) async {
    DocumentReference _ref = _eventsRef.doc();

    Event newEvent = event.copy(uid: _ref.id);
    await _ref.set(newEvent.toJSON());
  }

  // Read
  static Future<List<Event>> readMyEvents(BuildContext context) async {
    List<Event> eventList = [];
    // Check creator
    Query query = _eventsRef.where(
      'creator',
      isEqualTo: AuthService.currentUserId!,
    );
    QuerySnapshot querySnapshot = await query.get();

    for (var doc in querySnapshot.docs) {
      Event event = Event.fromJSON(doc.data());
      eventList.add(event);
    }

    // Check admin
    query = _eventsRef.where(
      'admins',
      arrayContains: AuthService.currentUserId!,
    );
    querySnapshot = await query.get();

    for (var doc in querySnapshot.docs) {
      Event event = Event.fromJSON(doc.data());
      eventList.add(event);
    }

    // Check member
    query = _eventsRef.where(
      'members',
      arrayContains: AuthService.currentUserId!,
    );
    querySnapshot = await query.get();

    for (var doc in querySnapshot.docs) {
      Event event = Event.fromJSON(doc.data());
      eventList.add(event);
    }

    // Sort
    eventList.sort((a, b) {
      return b.endDate.compareTo(a.endDate);
    });

    // return

    return eventList;
  }

  // Read
  static Future<Event?> readEventFromUID(BuildContext context, {required String uid}) async {
    Event? event;
    DocumentReference _ref = _eventsRef.doc(uid);
    DocumentSnapshot documentSnapshot = await _ref.get();

    if (documentSnapshot.exists) {
      event = Event.fromJSON(documentSnapshot.data());
    }

    return event;
  }

  // Read
  static Future<Event?> readEventFromCode(BuildContext context, {required String code}) async {
    Event? event;
    Query eventQuery = _db.collection('events').where('shareId', isEqualTo: code);

    QuerySnapshot querySnapshot = await eventQuery.get();

    if (querySnapshot.docs.isNotEmpty) {
      event = Event.fromJSON(querySnapshot.docs[0].data());
    }

    return event;
  }

  // Update
  static Future<bool> update(BuildContext context, {required Event event}) async {
    bool _success = false;
    DocumentReference ref = _db.collection('events').doc(event.uid!);

    await ref.update(event.toJSON()).whenComplete(() {
      _success = true;
    }).onError((error, stackTrace) {
      _success = false;
    });

    return _success;
  }

  // Delete
  static Future deleteEvent(BuildContext context, {required String uid}) async {
    DocumentReference ref = _db.collection('events').doc(uid);

    await ref.delete();
  }

  // Delete
  static Future deleteUserCreatedEvents(BuildContext context, {required String userId}) async {
    try {
      await _eventsRef.where('creator', isEqualTo: userId).get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message ?? 'There was an issue deleting your events.');
    }
  }
}
