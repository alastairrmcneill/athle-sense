import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';
import 'package:wellness_tracker/features/today/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class AlreadyCompleted extends StatelessWidget {
  const AlreadyCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.black45, width: 1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              // offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            const Text('You have compeleted today\'s survey'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: WellnessRadarChart(
                response: responseNotifier.myResponses!.first,
              ),
            ),
            const CountdownTimer(),
          ],
        ),
      ),
    );
  }
}
