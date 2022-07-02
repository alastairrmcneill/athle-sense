import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/home/screens/screens.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class EventTile extends StatelessWidget {
  final Event event;
  EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return GestureDetector(
      onTap: () {
        eventNotifier.setCurrentEvent = event;
        Navigator.push(context, MaterialPageRoute(builder: (_) => const EventDetailScreen()));
      },
      child: Container(
        height: 50,
        color: Colors.red,
        child: Text(event.name),
      ),
    );
  }
}
