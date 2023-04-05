import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class AllTeamResponses extends StatelessWidget {
  const AllTeamResponses({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    List<Member> members = eventNotifier.currentEventMembers!;
    List<Response> responses = eventNotifier.currentEventData!.todaysResponses;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Responses',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: members.map((member) {
          List<Response> todaysResponses = eventNotifier.currentEventData!.todaysResponses.where((element) => member.uid == element.userUid).toList();
          Response? todaysResponse;
          if (todaysResponses.isNotEmpty) {
            todaysResponse = todaysResponses.first;
          }

          List<Response> yesterdaysResponses = eventNotifier.currentEventData!.yesterdayResponses.where((element) => member.uid == element.userUid).toList();
          Response? yesterdaysResponse;
          if (yesterdaysResponses.isNotEmpty) {
            yesterdaysResponse = yesterdaysResponses.first;
          }

          List<Response> allResponses = eventNotifier.currentEventData!.allResponses.where((element) => member.uid == element.userUid).toList();
          double baseline = 0;
          if (allResponses.isNotEmpty) {
            baseline = allResponses.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / allResponses.length;
          }

          return AllResponsesTile(
            member: member,
            todaysResponse: todaysResponse,
            yesterdaysResponse: yesterdaysResponse,
            baseline: baseline,
          );
        }).toList(),
      ),
    );
  }
}
