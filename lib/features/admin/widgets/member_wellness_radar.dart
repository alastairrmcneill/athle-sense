import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class MemberWellnessRadar extends StatelessWidget {
  const MemberWellnessRadar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return Container(
      width: double.infinity,
      height: 300,
      child: Center(
        child: RadarChart(
          features: ['Q1', 'Q2', 'Q3', 'Q4', 'Q5'],
          ticks: [1, 2, 3, 4, 5],
          data: [
            responseNotifier.currentResponse!.ratings,
            responseNotifier.allResponsesForMember![0].ratings,
          ],
        ),
      ),
    );
  }
}
