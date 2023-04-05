import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:wellness_tracker/models/member.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class IncompleteTab extends StatelessWidget {
  const IncompleteTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    EventData eventData = eventNotifier.currentEventData!;
    List incompleteMemberIDs = [];
    if (eventData.incompleteMemberIDs.length < 5) {
      incompleteMemberIDs = eventData.incompleteMemberIDs;
    } else {
      incompleteMemberIDs = eventData.incompleteMemberIDs.sublist(0, 5);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 15),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: MyColors.lightTextColor!.withOpacity(0.5),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'Incomplete survey',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: incompleteMemberIDs.map((id) {
              List<Member> members = eventNotifier.currentEventMembers!.where((member) => member.uid == id).toList();
              if (members.isEmpty) return const SizedBox();

              Member member = members.first;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                child: Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => AllTeamResponses()));
            },
            child: const Text('See more...'),
          ),
        ),
      ],
    );
  }
}
