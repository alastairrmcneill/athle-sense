import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/event_database.dart';
import 'package:reading_wucc/services/services.dart';

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
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
    _refresh(eventNotifier, responseNotifier);
  }

  Future _refresh(EventNotifier eventNotifier, ResponseNotifier responseNotifier) async {
    EventDatabase.readEventMembers(eventNotifier);
    ResponseDatabase.readEventResponses(responseNotifier, eventNotifier.currentEvent!.uid!);
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return eventNotifier.currentEventMembers == null
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              _refresh(eventNotifier, responseNotifier);
            },
            child: ListView(
              children: eventNotifier.currentEventMembers!.map((member) {
                Response? _response;

                if (responseNotifier.allResponses != null) {
                  for (var response in responseNotifier.allResponses!) {
                    if (member.uid == response.userUid) {
                      _response = response;
                      break;
                    }
                  }
                }

                return MemberTile(member: member, response: _response);
              }).toList(),
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
