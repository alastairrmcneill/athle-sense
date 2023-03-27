import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return Container(
      child: Column(children: eventNotifier.myEvents!.map((event) => EventListTile(event: event)).toList()),
    );
  }
}
