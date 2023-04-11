import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';

class EventNotStarted extends StatelessWidget {
  const EventNotStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This group will open in',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          CountdownTimer(),
        ],
      ),
    );
  }
}
