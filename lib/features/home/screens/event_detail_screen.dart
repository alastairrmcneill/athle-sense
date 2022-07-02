import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return Center(
      child: Text(eventNotifier.currentEvent!.name),
    );
  }
}
