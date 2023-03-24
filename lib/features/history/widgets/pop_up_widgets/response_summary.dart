import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/response.dart';
import 'package:intl/intl.dart';

showResponseSummaryDialog(BuildContext context, {required Response response}) {
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('dd/MM/yy').format(response.date),
          ),
          const SizedBox(height: 10),
          WellnessRadarChart(response: response),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[300])),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          )
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DaySummaryCard(date: response.date, response: response);
    },
  );
}
