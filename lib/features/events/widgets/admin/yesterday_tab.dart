import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class YesterdayTab extends StatelessWidget {
  const YesterdayTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;
    EventData eventData = eventNotifier.currentEventData!;

    List differenceFromYesterday = [];
    if (eventData.differenceFromYesterday.length < 5) {
      differenceFromYesterday = eventData.differenceFromYesterday;
    } else {
      differenceFromYesterday = eventData.differenceFromYesterday.sublist(0, 5);
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
                'Decreases from yesterday',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: differenceFromYesterday.map((entry) {
              Member member = eventNotifier.currentEventMembers!.firstWhere((member) => member.uid == entry['memberID']);
              int difference = entry['difference'] as int;
              if (difference == 100) return const SizedBox();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                child: Text(
                  '${member.name}: $difference',
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
