import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:intl/intl.dart';

class EventFinished extends StatelessWidget {
  const EventFinished({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This group closed on',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            DateFormat.yMMMMd().format(event.endDate),
            style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 32),
          ),
        ],
      ),
    );
  }
}
