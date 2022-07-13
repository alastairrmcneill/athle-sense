import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/custom_dialog_box.dart';
import 'package:reading_wucc/features/admin/widgets/member_tile.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/support/theme.dart';

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
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: eventNotifier.currentEventMembers!.map((member) => MemberTile(member: member)).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        showShareCodDialog(context: context, event: eventNotifier.currentEvent!);
                      },
                      child: Text(
                        'Share',
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: MyColors.backgroundColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
