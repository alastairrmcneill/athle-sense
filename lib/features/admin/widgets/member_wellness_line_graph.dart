import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/support/theme.dart';

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
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 10),
      height: 200,
      child: responseNotifier.allResponses != null
          ? Center(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
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
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(
                    show: false,
                    border: const Border(
                      left: BorderSide(color: Colors.teal, width: 2),
                      bottom: BorderSide(color: Colors.teal, width: 2),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      dotData: FlDotData(show: false),
                      barWidth: 2,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [Colors.tealAccent, Colors.teal.withOpacity(0)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      isCurved: true,
                      curveSmoothness: 0.3,
                      color: Colors.teal,
                      isStrokeCapRound: true,
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
