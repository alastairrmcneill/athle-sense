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
    return TableCalendar(
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2099, 12, 31),
      focusedDay: DateTime.now(),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarBuilders: CalendarBuilders(
        // todayBuilder: (context, day, focusedDay) {
        //   DateTime recent = responseNotifier.myResponses!.first.date;
        //   DateTime now = DateTime.now();
        //   if (recent.year == day.year && recent.month == day.month && recent.day == day.day) {
        //     return GestureDetector(
        //       onTap: () {
        //         Response response = responseNotifier.myResponses!.first;
        //         showResponseSummaryDialog(context, response: response);
        //       },
        //       child: Container(
        //         color: myCalendarColors[responseNotifier.myResponses!.first.wellnessRating - 5],
        //         child: Center(
        //           child: Stack(
        //             alignment: AlignmentDirectional.center,
        //             children: [
        //               Container(
        //                 margin: const EdgeInsets.all(5),
        //                 decoration: BoxDecoration(
        //                   shape: BoxShape.circle,
        //                   border: Border.all(
        //                     color: Colors.white.withOpacity(0.7),
        //                   ),
        //                 ),
        //               ),
        //               Text(
        //                 '${day.day}',
        //                 style: const TextStyle(color: Colors.white),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     );
        //   } else if (now.year == day.year && now.month == day.month && now.day == day.day) {
        //     return Center(
        //       child: Stack(
        //         alignment: AlignmentDirectional.center,
        //         children: [
        //           Container(
        //             margin: const EdgeInsets.all(5),
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               border: Border.all(
        //                 color: Colors.black.withOpacity(0.4),
        //               ),
        //             ),
        //           ),
        //           Text(
        //             '${day.day}',
        //           ),
        //         ],
        //       ),
        //     );
        //   } else {
        //     return Center(
        //       child: Text('${day.day}'),
        //     );
        //   }
        // },
        defaultBuilder: (context, day, focusedDay) {
          for (var response in responseNotifier.myResponses!) {
            if (response.date.year == day.year && response.date.month == day.month && response.date.day == day.day) {
              return GestureDetector(
                onTap: () {
                  showResponseSummaryDialog(context, response: response);
                },
                child: Container(
                  color: myCalendarColors[response.wellnessRating - 5],
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
        },
      ),
    );
  }
}
