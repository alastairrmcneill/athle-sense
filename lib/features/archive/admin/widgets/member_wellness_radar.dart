import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/question.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:wellness_tracker/support/theme.dart';

class MemberWellnessRadar extends StatelessWidget {
  const MemberWellnessRadar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return Stack(
      children: [
        Positioned(
            top: 0,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 4, backgroundColor: Colors.teal),
                    Text('  Current', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const CircleAvatar(radius: 4, backgroundColor: Colors.tealAccent),
                    Text('  Baseline', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12)),
                  ],
                ),
              ],
            )),
        Center(
          child: RadarChart(
            features: Questions.short,
            ticks: const [1, 2, 3, 4, 5, 6],
            data: [
              responseNotifier.currentResponse!.ratings,
              responseNotifier.allResponsesForMember![0].ratings,
            ],
            graphColors: const [Colors.teal, Colors.tealAccent],
            axisColor: MyColors.darkTextColor!,
            outlineColor: MyColors.darkTextColor!,
            featuresTextStyle: Theme.of(context).textTheme.headline6!,
            ticksTextStyle: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
