import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wellness_tracker/features/history/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';
import 'package:intl/intl.dart';

class ResponseCalendar extends StatelessWidget {
  const ResponseCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
          child: TableCalendar(
            firstDay: DateTime(2000, 1, 1),
            lastDay: DateTime(2099, 12, 31),
            focusedDay: DateTime.now(),
            startingDayOfWeek: StartingDayOfWeek.monday,
            availableGestures: AvailableGestures.horizontalSwipe,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: Theme.of(context).textTheme.headline5!,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).textTheme.headline5!.color!,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Theme.of(context).textTheme.headline5!.color!,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(context).textTheme.headline6!,
              weekendStyle: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).textTheme.headline5!.color!.withOpacity(0.6)),
            ),
            calendarBuilders: CalendarBuilders(
              outsideBuilder: (context, day, focusedDay) => Center(
                child: Text(
                  '${day.day}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).textTheme.headline5!.color!.withOpacity(0.2),
                      ),
                ),
              ),
              todayBuilder: (context, day, focusedDay) {
                DateTime recent = responseNotifier.myResponses!.last.date;
                DateTime now = DateTime.now();

                if (DateUtils.isSameDay(now, recent)) {
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
                              color: Colors.white.withOpacity(0.4),
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
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).textTheme.headline5!.color!.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Text(
                          '${day.day}',
                          style: TextStyle(color: Theme.of(context).textTheme.headline5!.color!),
                        ),
                      ],
                    ),
                  );
                }
              },
              defaultBuilder: (context, day, focusedDay) {
                bool exists = false;
                for (var response in responseNotifier.myResponses!) {
                  if (DateUtils.isSameDay(day, response.date)) {
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
                            color: Theme.of(context).textTheme.headline5!.color!.withOpacity(day.weekday > 5 ? 0.6 : 1),
                          ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
