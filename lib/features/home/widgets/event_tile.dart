import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/screens/screens.dart';
import 'package:reading_wucc/features/member/screens/screens.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/support/theme.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  String _buildDateString() {
    String startDate = DateFormat('dd/MM/yyyy').format(event.startDate);
    String endDate = DateFormat('dd/MM/yyyy').format(event.endDate);

    return '$startDate - $endDate';
  }

  String _buildMembersString() {
    int members = event.members.length + event.admins.length;
    if (members == 1) {
      return '$members member';
    }
    return '$members members';
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return GestureDetector(
      onTap: () {
        eventNotifier.setCurrentEvent = event;
        Navigator.push(context, MaterialPageRoute(builder: (_) => event.amAdmin ? const EventDetailAdmin() : const EventDetailMember()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: MyColors.lightBlueColor,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  event.name,
                  maxLines: 2,
                  wrapWords: true,
                  minFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 15),
                Text(
                  _buildDateString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 10),
                Text(
                  _buildMembersString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Text(
                        event.amAdmin ? 'Admin' : '',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
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
