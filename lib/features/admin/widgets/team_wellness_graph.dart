import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:fl_chart/fl_chart.dart';

class WellnessChart extends StatelessWidget {
  const WellnessChart({Key? key}) : super(key: key);

  List<FlSpot> _buildData(ResponseNotifier responseNotifier) {
    List<List<Response>> responsesEachDay = responseNotifier.responseEachDay!;
    List<double> averages = [];
    List<FlSpot> spots = [];

    for (var day in responsesEachDay) {
      int sum = 0;
      int count = day.length;

      for (var response in day) {
        sum += response.wellnessRating;
      }

      double average = sum / count;

      averages.add(average);
    }
    for (var i = 1; i <= averages.length; i++) {
      spots.add(FlSpot(i.toDouble(), averages[i - 1]));
    }

    return spots;
    // int count = responsesEachDay.length;
    // List<int> sums = [for (var i = 0; i < responsesEachDay[0].ratings.length; i++) 0];

    // for (var response in responses) {
    //   for (var i = 0; i < sums.length; i += 1) {
    //     sums[i] += response.ratings[i];
    //   }
    // }

    // List<double> averages = sums.map((e) => e / count).toList();
    // return averages.toString();
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 10),
      height: 200,
      color: Colors.purple,
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
