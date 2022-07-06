import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/custom_dialog_box.dart';
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
        : Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView(
                  children: eventNotifier.currentEventMembers!.map((member) => MemberTile(member: member)).toList(),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    showShareCodDialog(context: context, event: eventNotifier.currentEvent!);
                  },
                  child: Text('Share')),
            ],
          );
  }
}
