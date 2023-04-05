import 'dart:math';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class EventService {
  static Future create(BuildContext context, {required String name, required DateTime startDate, required DateTime endDate}) async {
    showCircularProgressOverlay(context);
    try {
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
      await EventDatabase.create(context, event: event);

      // Update notifiers
      await loadUserEvents(context);

      stopCircularProgressOverlay(context);
      showSnackBar(context, 'Successfully created event');
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue creating your event.');
    }
  }

  static Future update(BuildContext context, {required Event event, required String name, required DateTime startDate, required DateTime endDate}) async {
    showCircularProgressOverlay(context);
    try {
      // Complete event
      Event newEvent = event.copy(
        name: name,
        startDate: startDate,
        endDate: endDate,
      );

      // Write to database
      await EventDatabase.update(context, event: newEvent);

      // Update notifiers
      EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
      eventNotifier.setCurrentEvent = newEvent;
      await loadUserEvents(context);

      stopCircularProgressOverlay(context);
      showSnackBar(context, 'Successfully updated event');
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue updating your event.');
    }
  }

  static Future joinEvent(BuildContext context, {required String code}) async {
    // Check there is a logged in user
    String? userId = AuthService.currentUserId;
    if (userId == null) {
      showErrorDialog(context, "Error: Logout and log back in to reset");
      return; // Return if not
    }

    showCircularProgressOverlay(context);
    try {
      // Find event
      Event? event = await EventDatabase.readEventFromCode(context, code: code);

      if (event == null) {
        stopCircularProgressOverlay(context);
        showSnackBar(context, 'No event exists with that code.');
        return;
      }

      // Add user
      event.members.add(AuthService.currentUserId!);

      // Update event
      await EventDatabase.update(context, event: event);

      // Update notifiers
      await loadUserEvents(context);
      stopCircularProgressOverlay(context);
      showSnackBar(context, 'Successfully joined event');
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue joining your event.');
    }
  }

  static Future loadUserEvents(BuildContext context) async {
    // Read from Database
    List<Event> eventList = await EventDatabase.readMyEvents(context);

    // Update notifier
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.setMyEvents = eventList;
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
    List<String> completeMemberIDs = [];
    for (String memberUID in allMemberUIDs) {
      if (todaysResponses.where((Response response) => response.userUid == memberUID).toList().isEmpty) {
        incompleteMemberIDs.add(memberUID);
      } else {
        completeMemberIDs.add(memberUID);
      }
    }

    // Available players
    List<String> availableMemberIDs = [];
    List<String> reducedAvailabilityMemberIDs = [];
    for (Response response in todaysResponses) {
      if (response.availability < 4) {
        reducedAvailabilityMemberIDs.add(response.userUid);
      } else {
        availableMemberIDs.add(response.userUid);
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
        completeMemberIDs: completeMemberIDs,
        reducedAvailabilityMemberIDs: reducedAvailabilityMemberIDs,
        availableMemberIDs: availableMemberIDs,
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
      if (!DateUtils.dateOnly(now).isBefore(DateUtils.dateOnly(event.startDate)) && !DateUtils.dateOnly(now).isAfter(DateUtils.dateOnly(event.endDate))) {
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
    showCircularProgressOverlay(context);

    try {
      event.admins.add(member.uid);
      event.members.remove(member.uid);
      await EventDatabase.update(context, event: event);

      // Reload notifiers
      EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
      eventNotifier.setCurrentEvent = event;

      stopCircularProgressOverlay(context);
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue updating the user level.');
    }
  }

  static Future setMemberAsMember(BuildContext context, {required Event event, required Member member}) async {
    showCircularProgressOverlay(context);

    try {
      // Update event
      event.members.add(member.uid);
      event.admins.remove(member.uid);
      await EventDatabase.update(context, event: event);

      // Reload notifiers
      EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
      eventNotifier.setCurrentEvent = event;

      stopCircularProgressOverlay(context);
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue updating the user level.');
    }
  }

  static Future removeUserFromEvent(BuildContext context, {required Event event, required Member member}) async {
    showCircularProgressOverlay(context);

    try {
      // Update event
      event.members.remove(member.uid);
      event.admins.remove(member.uid);
      await EventDatabase.update(context, event: event);

      // Reload data
      EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
      eventNotifier.setCurrentEvent = event;

      await loadEventData(context, event: event);
      await readMembersInEvent(context, event: event);

      stopCircularProgressOverlay(context);
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue removing this user.');
    }
  }

  static Future leaveEvent(BuildContext context, {required Event event}) async {
    showCircularProgressOverlay(context);

    try {
      event.members.remove(AuthService.currentUserId);
      event.admins.remove(AuthService.currentUserId);
      await EventDatabase.update(context, event: event);

      await loadUserEvents(context);
      stopCircularProgressOverlay(context);
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue leaving the event.');
    }
  }

  static Future deleteEvent(BuildContext context, {required Event event}) async {
    showCircularProgressOverlay(context);

    try {
      await EventDatabase.deleteEvent(context, uid: event.uid!);

      await loadUserEvents(context);

      stopCircularProgressOverlay(context);
    } on FirebaseException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue deleting your event.');
    }
  }

  static String _randomString(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();

    // check doesn't exist already
    return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  static int _randomInt() {
    const ch = '1234567890';
    Random r = Random();
    return int.parse(String.fromCharCodes(Iterable.generate(9, (_) => ch.codeUnitAt(r.nextInt(ch.length)))));
  }
}
