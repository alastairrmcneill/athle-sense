import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wellness_tracker/models/response.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

import 'package:syncfusion_flutter_charts/charts.dart' as sf;

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<double> averages = [0, 0, 0, 0, 0, 0, 0];
    List<SummaryChartData> chartData = [];
    List<SummaryChartData> totalChartData = [];

    for (var i = 0; i < daysOfWeek.length; i++) {
      List<Response> dayResponses = responseNotifier.myFilteredResponses!.where((response) => response.date.weekday == i + 1).toList();
      if (dayResponses.isNotEmpty) {
        averages[i] = dayResponses.map((Response response) => response.wellnessRating).reduce((a, b) => a + b) / dayResponses.length;
      }
    }

    for (var i = 0; i < daysOfWeek.length; i++) {
      chartData.add(SummaryChartData(daysOfWeek[i], averages[i]));
    }

    for (var i = 0; i < daysOfWeek.length; i++) {
      totalChartData.add(SummaryChartData(daysOfWeek[i], 25));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).textTheme.headline5!.color!.withOpacity(0.5),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Daily Wellness',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: sf.SfCartesianChart(
                  margin: const EdgeInsets.all(0),
                  enableSideBySideSeriesPlacement: false,
                  legend: sf.Legend(isVisible: false),
                  primaryXAxis: sf.CategoryAxis(
                    isVisible: true,
                    labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.headline5!.color!,
                      fontWeight: FontWeight.w200,
                    ),
                    majorTickLines: const sf.MajorTickLines(color: Colors.transparent),
                    majorGridLines: const sf.MajorGridLines(color: Colors.transparent),
                    axisBorderType: sf.AxisBorderType.withoutTopAndBottom,
                    borderColor: Colors.transparent,
                    axisLine: sf.AxisLine(color: Theme.of(context).textTheme.headline5!.color!.withOpacity(0), width: 0.5),
                  ),
                  borderColor: Colors.transparent,
                  plotAreaBorderColor: Colors.transparent,
                  primaryYAxis: sf.NumericAxis(
                    isVisible: false,
                    maximum: 25,
                    minimum: 3,
                  ),
                  series: <sf.ChartSeries>[
                    sf.ColumnSeries<SummaryChartData, String>(
                      width: 0.4,
                      spacing: 0.5,
                      dataSource: totalChartData,
                      xValueMapper: (SummaryChartData exp, _) => exp.wellnessCategory,
                      yValueMapper: (SummaryChartData exp, _) => exp.rating,
                      animationDuration: 400,
                      pointColorMapper: (datum, index) {
                        return Colors.grey.withOpacity(settingsNotifier.darkMode ? 0.2 : 0.1);
                      },
                      // borderRadius: const BorderRadius.only(
                      //   topLeft: Radius.circular(100),
                      //   topRight: Radius.circular(100),
                      // ),

                      borderRadius: BorderRadius.circular(100),
                    ),
                    sf.ColumnSeries<SummaryChartData, String>(
                      width: 0.4,
                      spacing: 0.5,
                      dataSource: chartData,
                      xValueMapper: (SummaryChartData exp, _) => exp.wellnessCategory,
                      yValueMapper: (SummaryChartData exp, _) => exp.rating,
                      animationDuration: 400,
                      pointColorMapper: (datum, index) {
                        if (datum.rating == 0) return Colors.transparent;
                        return myCalendarColors[(datum.rating).round() - 5].withOpacity(0.9);
                      },
                      // borderRadius: const BorderRadius.only(
                      //   topLeft: Radius.circular(100),
                      //   topRight: Radius.circular(100),
                      // ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryChartData {
  SummaryChartData(this.wellnessCategory, this.rating);
  final String wellnessCategory;
  final double rating;
}
