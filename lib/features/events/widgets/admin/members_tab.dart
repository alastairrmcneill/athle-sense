import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;

    if (eventNotifier.currentEventMembers == null) return const Center(child: CircularProgressIndicator());

    return ListView.separated(
      itemBuilder: (context, index) {
        Member member = eventNotifier.currentEventMembers![index];
        return MemberTile(member: member);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: eventNotifier.currentEventMembers!.length,
    );
  }
}
