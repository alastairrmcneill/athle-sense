import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class MemberEventDetailScreen extends StatelessWidget {
  const MemberEventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.name,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: false,
      ),
      body: event.startDate.isAfter(DateTime.now())
          ? const EventNotStarted()
          : event.endDate.isBefore(DateTime.now())
              ? const EventFinished()
              : const MemberEventView(),
    );
  }
}
