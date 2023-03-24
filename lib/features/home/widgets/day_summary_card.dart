// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: MyColors.cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                child: Text(
                  date == null ? 'You have compeleted today\'s survey!' : DateFormat.yMMMMd().format(date!),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.w200,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: MyColors.lightTextColor!.withOpacity(0.3),
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
            Divider(
              color: MyColors.lightTextColor!.withOpacity(0.3),
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
                            0.11,
                          ],
                          colors: [
                            ratingColors[rating - 1].withOpacity(0.7),
                            ratingColors[rating - 1].withOpacity(0.7),
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
    );
  }
}
