import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';

class EventDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  static Future createEvent(UserNotifier userNotiifer, Event event) async {
    DocumentReference ref = _db.collection('Events').doc();

    Event newEvent = event.copy(uid: ref.id);

    await ref.set(newEvent.toJSON()).whenComplete(() async {
      AppUser user = userNotiifer.currentUser!;
      user.events.add(newEvent.uid!);

      await UserDatabase.updateUser(userNotiifer, user);
    });
  }

  // Read
  static readMyEvents(EventNotifier eventNotifier) async {
    List<Event> _eventList = [];
    String uid = AuthService.getCurrentUserUID();

    // Check admin
    final CollectionReference ref = _db.collection('Events');
    final Query adminEvents = ref.where(
      'admins',
      arrayContains: uid,
    );
    await adminEvents.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Event event = Event.fromJSON(doc);
        Event newEvent = event.copy(amAdmin: true);

        _eventList.add(newEvent);
      });
    });

    // Check member
    final Query memberEvents = ref.where(
      'members',
      arrayContains: uid,
    );
    await memberEvents.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _eventList.add(Event.fromJSON(doc));
      });
    });

    // Sort

    // Set to notifier
    eventNotifier.setUserEvents = _eventList;
  }

  static Future readEventMembers(EventNotifier eventNotifier) async {
    List<Member> _membersList = [];
    List<String> allMembers = eventNotifier.currentEvent!.admins + eventNotifier.currentEvent!.members;

    final Query membersQuery = _db.collection('Users').where('uid', whereIn: allMembers);

    await membersQuery.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _membersList.add(Member.fromJSON(doc));
      });
    });

    eventNotifier.setCurrentEventMembers = _membersList;
  }

  // Update

  // Delete

}
