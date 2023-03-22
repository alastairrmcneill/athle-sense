import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/archive/member/widgets/daily_response_form.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class HisotryScreen extends StatelessWidget {
  const HisotryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    if (responseNotifier.myResponses == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (responseNotifier.myResponses!.isEmpty) {
      return const Center(child: Text('No responses yet'));
    }
    return const HistoryOverview();
  }
}
