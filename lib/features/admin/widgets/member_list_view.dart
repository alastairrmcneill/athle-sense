import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/event_database.dart';

class MemberListView extends StatefulWidget {
  const MemberListView({Key? key}) : super(key: key);

  @override
  State<MemberListView> createState() => _MemberListViewState();
}

class _MemberListViewState extends State<MemberListView> {
  @override
  void initState() {
    super.initState();

    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    _refresh(eventNotifier);
  }

  Future _refresh(EventNotifier eventNotifier) async {
    EventDatabase.readEventMembers(eventNotifier);
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return eventNotifier.currentEventMembers == null
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              _refresh(eventNotifier);
            },
            child: ListView(
              children: eventNotifier.currentEventMembers!.map((member) => MemberTile(member: member)).toList(),
            ),
          );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
  //   return eventNotifier.userEvents == null
  //       ? Center(child: CircularProgressIndicator())
  //       : RefreshIndicator(
  //           onRefresh: () async {
  //             _refresh(eventNotifier);
  //           },
  //           child: ListView(
  //             children: eventNotifier.userEvents!.map((event) => EventTile(event: event)).toList(),
  //           ),
  //         );
  // }
