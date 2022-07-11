import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/home/widgets/widgets.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/event_database.dart';

class EventListView extends StatefulWidget {
  const EventListView({Key? key}) : super(key: key);

  @override
  State<EventListView> createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  @override
  void initState() {
    super.initState();
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    EventDatabase.readMyEvents(eventNotifier);
  }

  Future _refresh(EventNotifier eventNotifier) async {
    EventDatabase.readMyEvents(eventNotifier);
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return eventNotifier.userEvents == null
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              _refresh(eventNotifier);
            },
            child: eventNotifier.userEvents!.isEmpty
                ? const Center(child: Text('Press the + to create or join a team'))
                : ListView(children: [
                    Text('Here are your events:'),
                    ...eventNotifier.userEvents!.map((event) => EventTile(event: event)).toList(),
                  ]),
          );
  }
}
