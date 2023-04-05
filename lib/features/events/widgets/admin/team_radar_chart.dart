import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class TeamRadarChart extends StatelessWidget {
  const TeamRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    EventData eventData = eventNotifier.currentEventData!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: SizedBox(
        height: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: RadarChart(
                    features: myQuestions.map((question) => question.short).toList(),
                    ticks: const [1, 2, 3, 4, 5, 6],
                    data: [
                      eventData.baselineRatings,
                      eventData.averageRatingsToday,
                    ],
                    graphColors: [
                      Colors.black26.withOpacity(0.1),
                      Theme.of(context).canvasColor,
                    ],
                    axisColor: Theme.of(context).textTheme.headline6!.color!.withOpacity(0.1),
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
                          CircleAvatar(radius: 4, backgroundColor: Theme.of(context).canvasColor),
                          Text('  Team Average Today', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12)),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(radius: 4, backgroundColor: Colors.black26),
                          Text('  Team Baseline', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
