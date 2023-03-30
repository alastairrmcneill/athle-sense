import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class BaselineTab extends StatelessWidget {
  const BaselineTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;
    EventData eventData = eventNotifier.currentEventData!;

    List differenceFromBaseline = [];
    if (eventData.differenceFromBaseline.length < 5) {
      differenceFromBaseline = eventData.differenceFromBaseline;
    } else {
      differenceFromBaseline = eventData.differenceFromBaseline.sublist(0, 5);
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
                'Farthest from their baseline',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: differenceFromBaseline.map((entry) {
              Member member = eventNotifier.currentEventMembers!.firstWhere((member) => member.uid == entry['memberID']);
              double difference = entry['difference'] as double;
              if (difference == 100 || difference > 0) return const SizedBox();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                child: Text(
                  '${member.name}: ${difference.toStringAsFixed(1)}',
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
            onPressed: () {},
            child: const Text('See more...'),
          ),
        ),
      ],
    );
  }
}
