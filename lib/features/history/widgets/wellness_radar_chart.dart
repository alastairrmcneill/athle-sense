// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class WellnessRadarChart extends StatelessWidget {
  final Response response;
  const WellnessRadarChart({
    Key? key,
    required this.response,
  }) : super(key: key);

  List<double> _findRunningAverage(ResponseNotifier responseNotifier) {
    List<double> runningAverage = [0.0, 0.0, 0.0, 0.0, 0.0];
    if (responseNotifier.myResponses!.length <= 14) {
      for (var i = 0; i < runningAverage.length; i++) {
        runningAverage[i] = responseNotifier.myResponses!.map((Response response) => response.ratings[i]).reduce((a, b) => a + b) / responseNotifier.myResponses!.length;
      }
    } else {
      List<Response> sublist = responseNotifier.myResponses!.sublist(0, 14);
      for (var i = 0; i < runningAverage.length; i++) {
        runningAverage[i] = sublist.map((Response response) => response.ratings[i]).reduce((a, b) => a + b) / sublist.length;
      }
    }
    return runningAverage;
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return Column(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: RadarChart(
            features: Questions.short,
            ticks: const [1, 2, 3, 4, 5, 6],
            data: [
              response.ratings,
              _findRunningAverage(responseNotifier),
            ],
            graphColors: const [Colors.teal, Colors.tealAccent],
            axisColor: Colors.black38,
            outlineColor: Colors.black45,
            featuresTextStyle: Theme.of(context).textTheme.headline6!,
            ticksTextStyle: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 4, backgroundColor: Colors.teal),
                  Text('  Day', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  const CircleAvatar(radius: 4, backgroundColor: Colors.tealAccent),
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
