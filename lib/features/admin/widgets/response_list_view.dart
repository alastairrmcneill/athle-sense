import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/event_database.dart';
import 'package:reading_wucc/services/services.dart';

class ResponseListView extends StatefulWidget {
  final int dayIndex;
  const ResponseListView({Key? key, required this.dayIndex}) : super(key: key);

  @override
  State<ResponseListView> createState() => _MemberListViewState();
}

class _MemberListViewState extends State<ResponseListView> {
  @override
  void initState() {
    super.initState();

    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return eventNotifier.currentEventMembers == null
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: eventNotifier.currentEventMembers!.map((member) {
                Response? _response;

                if (responseNotifier.responseEachDay != null) {
                  for (var response in responseNotifier.responseEachDay![widget.dayIndex]) {
                    if (member.uid == response.userUid) {
                      _response = response;
                      break;
                    }
                  }
                }

                return ResponseTile(member: member, response: _response);
              }).toList(),
            ),
          );
  }
}
