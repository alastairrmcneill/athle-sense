// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:intl/intl.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/auth_service.dart';
import 'package:wellness_tracker/support/theme.dart';

class EventListTile extends StatelessWidget {
  final Event event;
  const EventListTile({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        onTap: () {
          eventNotifier.setCurrentEvent = event;
          if (event.creator == AuthService.currentUserId! || event.admins.contains(AuthService.currentUserId!)) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminEventDetailScreen()));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const MemberEventDetailScreen()));
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        event.name,
                        style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 28),
                        minFontSize: 16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      event.creator == AuthService.currentUserId!
                          ? 'Creator'
                          : event.admins.contains(AuthService.currentUserId!)
                              ? 'Admin'
                              : '',
                      style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${DateFormat('dd/MM/yy').format(event.startDate)} - ${DateFormat('dd/MM/yy').format(event.endDate)}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
