// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class EventWellnessRadarChart extends StatelessWidget {
  final List<int> ratings;
  final List<double> baseline;
  const EventWellnessRadarChart({
    Key? key,
    required this.ratings,
    required this.baseline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 190,
          width: double.infinity,
          child: RadarChart(
            features: myQuestions.map((question) => question.short).toList(),
            ticks: const [1, 2, 3, 4, 5, 6],
            data: [
              baseline,
              ratings,
            ],
            graphColors: [
              Colors.black26.withOpacity(0.1),
              Colors.blueAccent,
            ],
            axisColor: MyColors.lightTextColor!.withOpacity(0.1),
            outlineColor: Colors.transparent,
            featuresTextStyle: Theme.of(context).textTheme.headline6!,
            ticksTextStyle: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.transparent),
          ),
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 4, backgroundColor: Colors.blueAccent),
                  Text('  Day', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(radius: 4, backgroundColor: Colors.black26),
                  Text('  Baseline', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
