import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class HistoryOverview extends StatelessWidget {
  const HistoryOverview({super.key});

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return SingleChildScrollView(
      child: Column(
        children: const [
          SummaryCard(),
          WellnessLineChart(),
          ResponseCalendar(),
        ],
      ),
    );
  }
}
