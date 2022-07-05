import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/member_tile.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class MembersTab extends StatefulWidget {
  const MembersTab({Key? key}) : super(key: key);

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return eventNotifier.currentEventMembers == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: eventNotifier.currentEventMembers!.map((member) => MemberTile(member: member)).toList(),
          );
  }
}
