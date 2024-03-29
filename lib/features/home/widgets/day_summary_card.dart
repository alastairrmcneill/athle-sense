// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/support/theme.dart';
import 'package:intl/intl.dart';

class DaySummaryCard extends StatelessWidget {
  final DateTime? date;
  final Response response;
  const DaySummaryCard({
    Key? key,
    this.date,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                    child: AutoSizeText(
                      date == null ? 'You have compeleted today\'s survey!' : DateFormat.yMMMMd().format(date!),
                      minFontSize: 22,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w200,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: WellnessRadarChart(
                      response: response,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: response.ratings.asMap().entries.map((entry) {
                        int index = entry.key;
                        int rating = entry.value;
                        return Container(
                          width: 55,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: const [
                                0,
                                0.1,
                                0.101,
                              ],
                              colors: [
                                ratingColors[rating - 1].withOpacity(0.8),
                                ratingColors[rating - 1].withOpacity(0.9),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                rating.toString(),
                                style: Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                myQuestions[index].short,
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
