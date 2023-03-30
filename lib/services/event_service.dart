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

  static Future loadEventData(BuildContext context, {required Event event}) async {
    // Load all data
    List<Response> allResponses = [];
    List<String> allMemberUIDs = [event.creator] + event.admins + event.members;

    for (String memberUID in allMemberUIDs) {
      List<Response> memberResponses = await ResponseDatabase.readMemberResponses(context, userUid: memberUID);
      allResponses.addAll(memberResponses);
    }
    // Process data
    // Today's responses
    List<Response> todaysResponses = allResponses.where((Response response) => DateUtils.isSameDay(response.date, DateTime.now())).toList();
    // Yesterday's responses
    List<Response> yesterdaysResponses = allResponses.where((Response response) => DateUtils.isSameDay(response.date, DateTime.now().subtract(Duration(days: 1)))).toList();

    // Baseline Ratings across all members
    List<double> baselineRatings = [0, 0, 0, 0, 0];
    if (allResponses.isNotEmpty) {
      for (var i = 0; i < baselineRatings.length; i++) {
        baselineRatings[i] = allResponses.map((Response response) => response.ratings[i]).reduce((a, b) => a + b) / allResponses.length;
      }
    }

    // Average Ratings across all members for today
    List<double> averageRatingsToday = [0, 0, 0, 0, 0];
    if (todaysResponses.isNotEmpty) {
      for (var i = 0; i < averageRatingsToday.length; i++) {
        averageRatingsToday[i] = todaysResponses.map((Response response) => response.ratings[i]).reduce((a, b) => a + b) / todaysResponses.length;
      }
    }

    // All team wellness baseline
    double teamWellnessBaseline = 0;
    if (allResponses.isNotEmpty) {
      teamWellnessBaseline = allResponses.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / allResponses.length;
    }

    // All team wellness today
    double teamWellnessToday = 0;
    if (todaysResponses.isNotEmpty) {
      teamWellnessToday = todaysResponses.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / todaysResponses.length;
    }

    // All team wellness yesterady
    double teamWellnessYesterday = 0;
    if (yesterdaysResponses.isNotEmpty) {
      teamWellnessYesterday = yesterdaysResponses.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / yesterdaysResponses.length;
    }

    // Incomplete
    List<String> incompleteMemberIDs = [];
    for (String memberUID in allMemberUIDs) {
      if (todaysResponses.where((Response response) => response.userUid == memberUID).toList().isEmpty) {
        incompleteMemberIDs.add(memberUID);
      }
    }

    // Health players
    List<String> reducedAvailabilityMemberIDs = [];
    for (Response response in todaysResponses) {
      if (response.availability < 4) {
        reducedAvailabilityMemberIDs.add(response.userUid);
      }
    }

    // Difference from yesterday
    List<Map> differenceFromYesterday = [];
    for (var memberID in allMemberUIDs) {
      List<Response> yesterdaysRespopnse = yesterdaysResponses.where((element) => element.userUid == memberID).toList();
      Response? yesterday = yesterdaysRespopnse.isNotEmpty ? yesterdaysRespopnse.first : null;

      List<Response> todaysResponse = todaysResponses.where((element) => element.userUid == memberID).toList();
      Response? today = todaysResponse.isNotEmpty ? todaysResponse.first : null;

      int difference = 0;

      if (today == null || yesterday == null) {
        difference = 100;
      } else {
        difference = today.wellnessRating - yesterday.wellnessRating;
      }
      differenceFromYesterday.add({
        'memberID': memberID,
        'difference': difference,
      });
    }

    differenceFromYesterday.sort(
      (a, b) => (a['difference'] as int).compareTo((b['difference'] as int)),
    );

    // Difference from baseline
    List<Map> differenceFromBaseline = [];
    for (var memberID in allMemberUIDs) {
      List<Response> todaysResponse = todaysResponses.where((element) => element.userUid == memberID).toList();
      Response? today = todaysResponse.isNotEmpty ? todaysResponse.first : null;

      List<Response> memberResponses = allResponses.where((element) => element.userUid == memberID).toList();

      double difference = 0;

      if (today == null || memberResponses.isEmpty) {
        difference = 100;
      } else {
        double memberBaseline = memberResponses.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / memberResponses.length;
        difference = today.wellnessRating - memberBaseline;
      }
      differenceFromBaseline.add({
        'memberID': memberID,
        'difference': difference,
      });
    }

    differenceFromBaseline.sort(
      (a, b) => (a['difference'] as double).compareTo((b['difference'] as double)),
    );

    // Load Members in event
    List<Member> _membersList = [];

    for (String memberID in allMemberUIDs) {
      Member? member = await UserDatabase.getMemberFromUID(memberID);
      if (member != null) {
        _membersList.add(member);
      }
    }

    // Update notifier
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.setCurrentEventData(
      EventData(
        baselineRatings: baselineRatings,
        averageRatingsToday: averageRatingsToday,
        teamWellnessBaseline: teamWellnessBaseline,
        teamWellnessToday: teamWellnessToday,
        teamWellnessYesterday: teamWellnessYesterday,
        incompleteMemberIDs: incompleteMemberIDs,
        reducedAvailabilityMemberIDs: reducedAvailabilityMemberIDs,
        allResponses: allResponses,
        todaysResponses: todaysResponses,
        yesterdayResponses: yesterdaysResponses,
        differenceFromYesterday: differenceFromYesterday,
        differenceFromBaseline: differenceFromBaseline,
      ),
      _membersList,
    );
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

  static Future leaveEvent(BuildContext context, {required Event event}) async {
    event.members.remove(AuthService.currentUserId);
    event.admins.remove(AuthService.currentUserId);
    await EventDatabase.update(context, event: event);

    await loadUserEvents(context);
  }

  static Future deleteEvent(BuildContext context, {required Event event}) async {
    await EventDatabase.deleteEvent(context, uid: event.uid!);
    await loadUserEvents(context);
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
