// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

import 'package:wellness_tracker/support/theme.dart';

class PercentSummaryTile extends StatelessWidget {
  final String title;
  final num total;
  final num partial;
  final Function onTap;
  const PercentSummaryTile({
    Key? key,
    required this.title,
    required this.total,
    required this.partial,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.23,
        height: MediaQuery.of(context).size.width * 0.23,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.width * 0.07,
                      lineWidth: 4,
                      percent: partial / total,
                      backgroundWidth: 1,
                      backgroundColor: Theme.of(context).textTheme.headline6!.color!.withOpacity(settingsNotifier.darkMode ? 0.6 : 0.2),
                      progressColor: myCalendarColors[((partial / total) * 19).round()],
                      circularStrokeCap: CircularStrokeCap.round,
                      center: AutoSizeText(
                        '$partial/$total',
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 1,
                        minFontSize: 10,
                        maxFontSize: 20,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 10),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
