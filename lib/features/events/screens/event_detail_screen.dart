// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({
    Key? key,
  }) : super(key: key);

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              event.name,
              style: Theme.of(context).textTheme.headline4!,
            ),
            ElevatedButton(
              onPressed: () {
                showShareEventDialog(context, code: event.shareId);
              },
              child: Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
