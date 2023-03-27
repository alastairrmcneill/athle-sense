import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class EventService {
  static Future<bool> create(BuildContext context, {required String name, required DateTime startDate, required DateTime endDate}) async {
    if (AuthService.currentUserId == null) return false;

    // Complete event
    Event event = Event(
      name: name,
      startDate: startDate,
      endDate: endDate,
      creator: AuthService.currentUserId!,
      admins: [],
      members: [],
      shareId: _randomString(6),
      notificationId: _randomInt(),
    );

    // Write to database
    bool success = await EventDatabase.createEvent(context, event: event);

    // Update notifiers
    await loadUserEvents(context);

    return success;
  }

  static Future<bool> joinEvent(BuildContext context, {required String code}) async {
    if (AuthService.currentUserId == null) return false;

    // Find event
    Event? event = await EventDatabase.readEventFromCode(context, code: code);

    if (event == null) return false;

    // Add user
    event.members.add(AuthService.currentUserId!);

    // Update event
    bool success = await EventDatabase.update(context, event: event);

    // Update notifiers
    await loadUserEvents(context);

    return success;
  }

  static Future loadUserEvents(BuildContext context) async {
    // Read from Database
    List<Event> eventList = await EventDatabase.readMyEvents(context);

    // Update notifier
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.setMyEvents = eventList;
  }

  static Future loadEvent(BuildContext context, {required String uid}) async {
    // Read from Database
    Event? event = await EventDatabase.readEventFromUID(context, uid: uid);

    if (event == null) return;

    // Update notifier
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.setCurrentEvent = event;
  }

  static bool inActiveEvent(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    DateTime now = DateTime.now();
    for (Event event in eventNotifier.myEvents ?? []) {
      if (now.isAfter(event.startDate) && now.isBefore(event.endDate)) {
        return true;
      }
    }
    return false;
  }

  static Future readMembersInEvent(BuildContext context, {required Event event}) async {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);

    List<Member> _membersList = [];
    List<String> _memberIDs = [event.creator] + eventNotifier.currentEvent!.admins + eventNotifier.currentEvent!.members;

    for (String memberID in _memberIDs) {
      Member? member = await UserDatabase.getMemberFromUID(memberID);
      if (member != null) {
        _membersList.add(member);
      }
    }

    eventNotifier.setCurrentEventMembers = _membersList;
  }

  static Future setMemberAsAdmin(BuildContext context, {required Event event, required Member member}) async {
    event.admins.add(member.uid);
    event.members.remove(member.uid);
    await EventDatabase.update(context, event: event);

    // Reload notifiers
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.setCurrentEvent = event;
  }

  static Future setMemberAsMember(BuildContext context, {required Event event, required Member member}) async {
    // Update event
    event.members.add(member.uid);
    event.admins.remove(member.uid);
    await EventDatabase.update(context, event: event);

    // Reload notifiers
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.setCurrentEvent = event;
  }

  static Future removeUserFromEvent(BuildContext context, {required Event event, required Member member}) async {
    event.members.remove(member.uid);
    event.admins.remove(member.uid);
    await EventDatabase.update(context, event: event);

    // Reload notifiers
    await readMembersInEvent(context, event: event);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.setCurrentEvent = event;
  }

  static String _randomString(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  static int _randomInt() {
    const ch = '1234567890';
    Random r = Random();
    return int.parse(String.fromCharCodes(Iterable.generate(9, (_) => ch.codeUnitAt(r.nextInt(ch.length)))));
  }
}

// Future<String> addEventToUser(UserNotifier userNotifier, EventNotifier eventNotifier, String code) async {
//   // Get current User ID
//   String userID = AuthService.currentUserId!;

//   // Get household
//   Event? event = await EventDatabase.readEventFromCode(eventNotifier, code);
//   AppUser? user = userNotifier.currentUser;

//   if (user != null && event != null) {
//     if (user.events.contains(event.uid)) {
//       return 'Already part of event.';
//     }
//     // Update user
//     user.events.add(event.uid!);
//     await UserDatabase.updateUser(userNotifier, user);

//     // Update event
//     event.members.add(userID);
//     await EventDatabase.updateEvent(eventNotifier, event);

//     // Create notifications
//     createScheduledNotification(id: event.notificationId, eventName: event.name);

//     // Return
//     return event.name;
//   }

//   return '';
// }

// Future leaveEvent(UserNotifier userNotifier, EventNotifier eventNotifier, ResponseNotifier responseNotifier) async {
// // Remove user from event members list
//   await EventDatabase.removeUserFromSpecificEvent(userNotifier.currentUser!.uid, eventNotifier.currentEvent!.uid!);

// // Remove event from user list
//   await UserDatabase.removeEvent(userNotifier, eventNotifier.currentEvent!.uid!);
// // Delete responses
//   await ResponseDatabase.deleteEventResponses(eventNotifier.currentEvent!.uid!, userNotifier.currentUser!.uid);

// // Update everything
//   await EventDatabase.readMyEvents(eventNotifier);
//   await UserDatabase.getCurrentUser(userNotifier);
// }
