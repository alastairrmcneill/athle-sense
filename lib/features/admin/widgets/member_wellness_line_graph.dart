import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class MemberWellnessLineGraph extends StatelessWidget {
  const MemberWellnessLineGraph({Key? key}) : super(key: key);

  List<FlSpot> _buildData(ResponseNotifier responseNotifier) {
    List<Response> responses = responseNotifier.allResponsesForMember!;
    List<FlSpot> spots = [];

    for (var i = 1; i <= responses.length; i++) {
      spots.add(FlSpot(i.toDouble(), responses[i - 1].wellnessRating.toDouble()));
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 10),
      height: 200,
      child: responseNotifier.allResponses != null
          ? Center(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, interval: 1)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  minX: 1,
                  maxX: 7,
                  minY: 0,
                  maxY: 25,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      dotData: FlDotData(show: false),
                      barWidth: 4,
                      isCurved: false,
                      color: Colors.black,
                      spots: _buildData(responseNotifier),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
