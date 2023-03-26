import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/features/today/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    if (responseNotifier.myResponses == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (responseNotifier.myResponses!.isEmpty) {
      return const TodayQuestionnaireForm();
    } else if (responseNotifier.myResponses!.last.date.isAfter(DateTime(now.year, now.month, now.day))) {
      return DaySummaryCard(
        response: responseNotifier.myResponses!.last,
      );
    }
    return const TodayQuestionnaireForm();
  }
}
