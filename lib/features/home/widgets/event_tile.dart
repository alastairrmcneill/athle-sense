import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/screens/screens.dart';
import 'package:reading_wucc/features/member/screens/screens.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return GestureDetector(
      onTap: () {
        eventNotifier.setCurrentEvent = event;
        Navigator.push(context, MaterialPageRoute(builder: (_) => event.amAdmin ? const EventDetailAdmin() : const EventDetailMember()));
      },
      child: Container(
        height: 50,
        color: event.amAdmin ? Colors.red : Colors.blue,
        child: Text(event.name),
      ),
    );
  }
}
