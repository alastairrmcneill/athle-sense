import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sf;
import 'package:intl/intl.dart';
import 'package:wellness_tracker/support/constants.dart';
import 'package:wellness_tracker/support/theme.dart';

class WellnessLineChart extends StatefulWidget {
  const WellnessLineChart({super.key});

  @override
  State<WellnessLineChart> createState() => _WellnessLineChartState();
}

class _WellnessLineChartState extends State<WellnessLineChart> {
  double _findRunningAverage(ResponseNotifier responseNotifier, int index) {
    double runningAverage = 0.0;
    List<Response> sublist = [];

    if (index < 28) {
      sublist = responseNotifier.myFilteredResponses!.sublist(0, index + 1);
    } else {
      sublist = responseNotifier.myFilteredResponses!.sublist(index - 28, index + 1);
    }

    runningAverage = sublist.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / sublist.length;

    return runningAverage;
  }

  Map<String, Object> _buildChartData(ResponseNotifier responseNotifier) {
    final List<ChartData> chartWellnessData = [];
    final List<ChartData> chartBaselineData = [];
    sf.DateTimeIntervalType intervalType = sf.DateTimeIntervalType.auto;
    double interval = 0;

    List<Response> allResponses = responseNotifier.myFilteredResponses ?? [];

    List<DateTime> dates = [];
    for (var response in allResponses) {
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
      interval = 3;
    } else {
      intervalType = sf.DateTimeIntervalType.years;
      interval = 1;
    }

    for (var i = 0; i < dates.length; i++) {
      var date = dates[i];
      var wellnessValue = allResponses[i].wellnessRating;

      chartWellnessData.add(ChartData(DateTime(date.year, date.month, date.day), wellnessValue.toDouble()));
      chartBaselineData.add(ChartData(DateTime(date.year, date.month, date.day), _findRunningAverage(responseNotifier, i)));
    }

    return {
      "chartWellnessData": chartWellnessData,
      "chartBaselineData": chartBaselineData,
      "intervalType": intervalType,
      "interval": interval,
    };
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    Map<String, Object> chartData = _buildChartData(responseNotifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: MyColors.cardColor,
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MyColors.lightTextColor!.withOpacity(0.5),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'History',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: LineChartLegend(),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 0, left: 10, right: 10, top: 10),
              height: 180,
              width: double.infinity,
              child: Center(
                child: sf.SfCartesianChart(
                  // General
                  plotAreaBorderWidth: 0,
                  margin: const EdgeInsets.only(left: 0, right: 15),
                  legend: sf.Legend(isVisible: false, position: sf.LegendPosition.top),
                  trackballBehavior: sf.TrackballBehavior(
                    enable: true,
                    activationMode: sf.ActivationMode.singleTap,
                  ),

                  // X axis
                  primaryXAxis: sf.DateTimeAxis(
                    isVisible: true,
                    labelStyle: TextStyle(
                      color: MyColors.lightTextColor,
                      fontWeight: FontWeight.w200,
                    ),
                    majorGridLines: const sf.MajorGridLines(width: 0),
                    interval: chartData["interval"] as double? ?? 1,
                    intervalType: chartData["intervalType"] as sf.DateTimeIntervalType? ?? sf.DateTimeIntervalType.auto,
                    axisLine: sf.AxisLine(color: MyColors.lightTextColor!.withOpacity(0.8), width: 0.5),
                    majorTickLines: sf.MajorTickLines(color: MyColors.lightTextColor!.withOpacity(0.8), width: 0.5),
                    enableAutoIntervalOnZooming: true,
                  ),
                  // Y Axis
                  primaryYAxis: sf.NumericAxis(
                    isVisible: true,
                    labelStyle: TextStyle(
                      color: MyColors.lightTextColor,
                      fontWeight: FontWeight.w200,
                    ),
                    minimum: 5,
                    maximum: 26,
                    numberFormat: NumberFormat.compact(),
                    majorGridLines: const sf.MajorGridLines(width: 0),
                    axisLine: sf.AxisLine(color: MyColors.lightTextColor!.withOpacity(0.8), width: 0.5),
                    majorTickLines: sf.MajorTickLines(color: MyColors.lightTextColor!.withOpacity(0.8), width: 0.5),
                    interval: 5,
                  ),
                  // Data
                  series: <sf.ChartSeries<ChartData, DateTime>>[
                    sf.SplineSeries<ChartData, DateTime>(
                      name: 'Wellness',
                      dataSource: chartData["chartWellnessData"] as List<ChartData>? ?? [],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      animationDuration: 400,
                      splineType: sf.SplineType.monotonic,
                      width: 1.5,
                    ),
                    sf.SplineSeries<ChartData, DateTime>(
                      name: 'Baseline',
                      dataSource: chartData["chartBaselineData"] as List<ChartData>? ?? [],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      animationDuration: 400,
                      width: 0.7,
                      dashArray: const [3, 3],
                      splineType: sf.SplineType.monotonic,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
