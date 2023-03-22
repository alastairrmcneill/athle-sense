import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sf;
import 'package:intl/intl.dart';

class WellnessLineChart extends StatefulWidget {
  const WellnessLineChart({super.key});

  @override
  State<WellnessLineChart> createState() => _WellnessLineChartState();
}

class _WellnessLineChartState extends State<WellnessLineChart> {
  List<String> options = ['1m', '6m', '1y', 'All'];
  int index = 3;

  double _findRunningAverage(ResponseNotifier responseNotifier) {
    double runningAverage = 0.0;
    if (responseNotifier.myResponses!.length <= 14) {
      runningAverage = responseNotifier.myResponses!.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / responseNotifier.myResponses!.length;
    } else {
      List<Response> sublist = responseNotifier.myResponses!.sublist(0, 14);
      runningAverage = sublist.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / sublist.length;
    }
    return runningAverage;
  }

  Map<String, Object> _buildChartData(ResponseNotifier responseNotifier) {
    final List<ChartData> chartWellnessData = [];
    final List<ChartData> chartAverageData = [];
    double runningAverage = _findRunningAverage(responseNotifier);
    sf.DateTimeIntervalType intervalType = sf.DateTimeIntervalType.auto;
    double interval = 0;
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.now();
    if (index == 0) {
      startDate = DateTime(now.year, now.month - 1, now.day);
    } else if (index == 1) {
      startDate = DateTime(now.year, now.month - 6, now.day);
    } else if (index == 2) {
      startDate = DateTime(now.year - 1, now.month, now.day);
    } else {
      startDate = DateTime(now.year - 100, now.month, now.day);
    }

    List<Response> allResponses = responseNotifier.myResponses ?? [];

    List<Response> responses = allResponses.where((response) => response.date.isAfter(startDate)).toList();

    List<DateTime> dates = [];
    for (var response in responses) {
      dates.add(response.date);
    }

    int daysBetweenStartAndEnd = dates.last.difference(dates.first).inDays;

    if (daysBetweenStartAndEnd < 10) {
      intervalType = sf.DateTimeIntervalType.days;
      interval = 1;
    } else if (daysBetweenStartAndEnd > 10 && daysBetweenStartAndEnd < 31) {
      intervalType = sf.DateTimeIntervalType.days;
      interval = 5;
    } else if (daysBetweenStartAndEnd < 400) {
      intervalType = sf.DateTimeIntervalType.months;
      interval = 2;
    } else {
      intervalType = sf.DateTimeIntervalType.years;
      interval = 1;
    }

    for (var i = 0; i < dates.length; i++) {
      var date = dates[i];
      var wellnessValue = responses[i].wellnessRating;

      chartWellnessData.add(ChartData(DateTime(date.year, date.month, date.day), wellnessValue.toDouble()));
      chartAverageData.add(ChartData(DateTime(date.year, date.month, date.day), runningAverage));
    }

    return {
      "chartWellnessData": chartWellnessData,
      "chartAverageData": chartAverageData,
      "intervalType": intervalType,
      "interval": interval,
    };
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    Map<String, Object> chartData = _buildChartData(responseNotifier);

    return Container(
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: sf.SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: const EdgeInsets.only(left: 0, right: 10),
              legend: sf.Legend(isVisible: true, position: sf.LegendPosition.top),
              primaryXAxis: sf.DateTimeAxis(
                majorGridLines: const sf.MajorGridLines(width: 0),
                interval: chartData["interval"] as double? ?? 1,
                intervalType: chartData["intervalType"] as sf.DateTimeIntervalType? ?? sf.DateTimeIntervalType.auto,
                enableAutoIntervalOnZooming: true,
              ),
              primaryYAxis: sf.NumericAxis(
                minimum: 0,
                maximum: 26,
                numberFormat: NumberFormat.compact(),
                majorGridLines: const sf.MajorGridLines(width: 0),
              ),
              series: <sf.ChartSeries<ChartData, DateTime>>[
                sf.SplineSeries<ChartData, DateTime>(
                  name: 'Wellness',
                  dataSource: chartData["chartWellnessData"] as List<ChartData>? ?? [],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  animationDuration: 400,
                  splineType: sf.SplineType.monotonic,
                ),
                // sf.SplineAreaSeries<ChartData, DateTime>(
                //   name: 'Wellness area',
                //   isVisibleInLegend: false,
                //   dataSource: chartData["chartWellnessData"] as List<ChartData>? ?? [],
                //   xValueMapper: (ChartData data, _) => data.x,
                //   yValueMapper: (ChartData data, _) => data.y,
                //   // color: MyColors.blueAccent,
                //   animationDuration: 400,
                //   opacity: 0.05,
                //   splineType: sf.SplineType.monotonic,
                // ),
                sf.LineSeries<ChartData, DateTime>(
                  name: 'Rolling average',
                  dataSource: chartData["chartAverageData"] as List<ChartData>? ?? [],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  animationDuration: 400,
                  width: 0.8,
                  dashArray: const [3, 3],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index += 1;
                  if (index == 4) index = 0;
                });
              },
              child: Container(
                width: 35,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green,
                ),
                child: Center(child: Text(options[index])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
