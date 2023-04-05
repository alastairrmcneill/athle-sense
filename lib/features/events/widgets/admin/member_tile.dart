import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/support/theme.dart';

class MemberTile extends StatelessWidget {
  final Member member;
  const MemberTile({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;
    return ListTile(
      title: Text(
        member.name,
        style: TextStyle(color: Theme.of(context).textTheme.headline6!.color!),
      ),
      trailing: Text(
        event.creator == member.uid
            ? 'Creator'
            : event.admins.contains(member.uid)
                ? 'Admin'
                : '',
        style: TextStyle(
          color: Theme.of(context).textTheme.headline6!.color!.withOpacity(0.8),
          fontWeight: FontWeight.w300,
        ),
      ),
      onTap: () {
        if (event.creator != member.uid && member.uid != AuthService.currentUserId!) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MemberEditScreen(member: member)));
        }
      },
    );
  }
}
