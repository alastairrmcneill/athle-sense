import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/event_database.dart';
import 'package:reading_wucc/services/services.dart';

class MemberListView extends StatefulWidget {
  final int dayIndex;
  const MemberListView({Key? key, required this.dayIndex}) : super(key: key);

  @override
  State<MemberListView> createState() => _MemberListViewState();
}

class _MemberListViewState extends State<MemberListView> {
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
        : ListView(
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

              return MemberTile(member: member, response: _response);
            }).toList(),
          );
  }
}
