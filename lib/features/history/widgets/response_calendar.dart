import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class ResponseCalendar extends StatelessWidget {
  const ResponseCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: MyColors.cardColor,
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
        width: double.infinity,
        child: TableCalendar(
          firstDay: DateTime(2000, 1, 1),
          lastDay: DateTime(2099, 12, 31),
          focusedDay: DateTime.now(),
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: Theme.of(context).textTheme.headline5!,
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: MyColors.lightTextColor,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: MyColors.lightTextColor,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context).textTheme.headline6!,
            weekendStyle: Theme.of(context).textTheme.headline6!.copyWith(color: MyColors.lightTextColor!.withOpacity(0.6)),
          ),
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, day, focusedDay) => Center(
              child: Text(
                '${day.day}',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: MyColors.lightTextColor!.withOpacity(0.2),
                    ),
              ),
            ),
            todayBuilder: (context, day, focusedDay) {
              DateTime recent = responseNotifier.myResponses!.last.date;
              DateTime now = DateTime.now();
              if (day.isAtSameMomentAs(DateUtils.dateOnly(recent))) {
                return GestureDetector(
                  onTap: () {
                    Response response = responseNotifier.myResponses!.last;
                    showResponseSummaryDialog(context, response: response);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: myCalendarColors[responseNotifier.myResponses!.last.wellnessRating - 5],
                    ),
                    child: Center(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                          Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (day.isAtSameMomentAs(DateUtils.dateOnly(now))) {
                return Center(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Text(
                        '${day.day}',
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: MyColors.lightTextColor),
                  ),
                );
              }
            },
            defaultBuilder: (context, day, focusedDay) {
              bool exists = false;
              for (var response in responseNotifier.myResponses!) {
                if (day.isAtSameMomentAs(DateUtils.dateOnly(response.date))) {
                  return GestureDetector(
                    onTap: () {
                      showResponseSummaryDialog(context, response: response);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: myCalendarColors[response.wellnessRating - 5],
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
              }
              if (!exists) {
                return Center(
                  child: Text(
                    '${day.day}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: MyColors.lightTextColor!.withOpacity(day.weekday > 5 ? 0.6 : 1),
                        ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
