import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/services/services.dart';

class EventDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _eventsRef = _db.collection('events');

  // Create
  static Future<bool> createEvent(BuildContext context, {required Event event}) async {
    bool _success = false;
    DocumentReference _ref = _eventsRef.doc();

    Event newEvent = event.copy(uid: _ref.id);

    try {
      await _ref.set(newEvent.toJSON()).whenComplete(() {
        _success = true;
      });
    } on FirebaseException catch (error) {
      _success = false;
    }
    return _success;
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

  // // Read
  // static readMyEvents(EventNotifier eventNotifier) async {
  //   List<Event> _eventList = [];
  //   String uid = AuthService.currentUserId!;

  //   // Check admin
  //   final CollectionReference ref = _db.collection('Events');
  //   final Query adminEvents = ref.where(
  //     'admins',
  //     arrayContains: uid,
  //   );
  //   await adminEvents.get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       Event event = Event.fromJSON(doc);
  //       Event newEvent = event.copy(amAdmin: true);

  //       _eventList.add(newEvent);
  //     });
  //   });

  //   // Check member
  //   final Query memberEvents = ref.where(
  //     'members',
  //     arrayContains: uid,
  //   );
  //   await memberEvents.get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       _eventList.add(Event.fromJSON(doc));
  //     });
  //   });

  //   // Sort

  //   // Check notifications
  //   await setScheduledNotifications(_eventList);

  //   // Set to notifier
  //   eventNotifier.setUserEvents = _eventList;
  // }

  // static Future readEventMembers(EventNotifier eventNotifier) async {
  //   List<Member> _membersList = [];
  //   List<String> allMembers = eventNotifier.currentEvent!.admins + eventNotifier.currentEvent!.members;

  //   final Query membersQuery = _db.collection('Users').where('uid', whereIn: allMembers);

  //   await membersQuery.get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       _membersList.add(Member.fromJSON(doc));
  //     });
  //   });

  //   eventNotifier.setCurrentEventMembers = _membersList;
  // }

  // static Future<Event?> readEventFromCode(EventNotifier eventNotifier, String code) async {
  //   Event? event;
  //   Query eventQuery = _db.collection('Events').where('shareId', isEqualTo: code);
  //   await eventQuery.get().then((QuerySnapshot querySnapshot) {
  //     if (querySnapshot.docs.isNotEmpty) {
  //       event = Event.fromJSON(querySnapshot.docs[0].data());
  //     }
  //   });
  //   return event;
  // }

  // // Update
  // static updateEvent(EventNotifier eventNotifier, Event event) async {
  //   DocumentReference ref = _db.collection('Events').doc(event.uid!);

  //   ref.update(event.toJSON()).whenComplete(() {
  //     readMyEvents(eventNotifier);
  //   });
  // }

  // static Future addAdmin(EventNotifier eventNotifier, String userUid) async {
  //   DocumentReference ref = _db.collection('Events').doc(eventNotifier.currentEvent!.uid);

  //   DocumentSnapshot result = await ref.get();

  //   if (result.exists) {
  //     Event oldEvent = Event.fromJSON(result.data());
  //     List<String> admins = oldEvent.admins;
  //     List<String> members = oldEvent.members;

  //     admins.add(userUid);
  //     members.remove(userUid);

  //     Event newEvent = oldEvent.copy(admins: admins, members: members);

  //     await ref.update(newEvent.toJSON());
  //   }
  // }

  // static Future removeAdmin(EventNotifier eventNotifier, String userUid) async {
  //   DocumentReference ref = _db.collection('Events').doc(eventNotifier.currentEvent!.uid);

  //   DocumentSnapshot result = await ref.get();

  //   if (result.exists) {
  //     Event oldEvent = Event.fromJSON(result.data());
  //     List<String> admins = oldEvent.admins;
  //     List<String> members = oldEvent.members;

  //     admins.remove(userUid);
  //     members.add(userUid);

  //     Event newEvent = oldEvent.copy(admins: admins, members: members);

  //     await ref.update(newEvent.toJSON());
  //   }
  // }

  // static Future removeUserFromSpecificEvent(String userUid, String eventUid) async {
  //   _db.collection('Events').doc(eventUid).get().then((snapshot) {
  //     if (snapshot.exists) {
  //       Event event = Event.fromJSON(snapshot.data());
  //       event.members.remove(userUid);

  //       snapshot.reference.update(event.toJSON());
  //     }
  //   });
  // }

  // static Future removeUserFromEvents(String uid) async {
  //   _db.collection('Events').where('admins', arrayContains: uid).get().then((snapshot) {
  //     for (DocumentSnapshot ds in snapshot.docs) {
  //       Event event = Event.fromJSON(ds.data());
  //       event.admins.remove(uid);

  //       ds.reference.update(event.toJSON());
  //     }
  //   });
  //   _db.collection('Events').where('members', arrayContains: uid).get().then((snapshot) {
  //     for (DocumentSnapshot ds in snapshot.docs) {
  //       Event event = Event.fromJSON(ds.data());
  //       event.members.remove(uid);

  //       ds.reference.update(event.toJSON());
  //     }
  //   });
  // }

  // // Delete
  // static Future deleteEvent(EventNotifier eventNotifier) async {
  //   DocumentReference ref = _db.collection('Events').doc(eventNotifier.currentEvent!.uid);

  //   await ref.delete();

  //   await readMyEvents(eventNotifier);
  // }
}
