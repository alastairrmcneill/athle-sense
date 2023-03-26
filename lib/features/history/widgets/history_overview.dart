import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';

class HistoryOverview extends StatelessWidget {
  const HistoryOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          TimeframeButtons(),
          WellnessLineChart(),
          SummaryCard(),
          ResponseCalendar(),
        ],
      ),
    );
  }
}
