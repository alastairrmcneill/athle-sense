// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/event_service.dart';
import 'package:wellness_tracker/support/theme.dart';

class MemberEditScreen extends StatelessWidget {
  final Member member;
  const MemberEditScreen({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            member.name,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          centerTitle: false,
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(
                'Admin',
                style: TextStyle(
                  color: MyColors.lightTextColor!.withOpacity(0.8),
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: event.admins.contains(member.uid)
                  ? Icon(
                      Icons.check,
                      color: MyColors.lightTextColor,
                    )
                  : const SizedBox(),
              onTap: () async {
                if (!event.admins.contains(member.uid)) {
                  await EventService.setMemberAsAdmin(context, event: event, member: member);
                }
              },
            ),
            Divider(color: MyColors.lightTextColor),
            ListTile(
              title: Text(
                'Member',
                style: TextStyle(
                  color: MyColors.lightTextColor!.withOpacity(0.8),
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: event.members.contains(member.uid)
                  ? Icon(
                      Icons.check,
                      color: MyColors.lightTextColor,
                    )
                  : const SizedBox(),
              onTap: () async {
                if (!event.members.contains(member.uid)) {
                  await EventService.setMemberAsMember(context, event: event, member: member);
                }
              },
            ),
            Divider(color: MyColors.lightTextColor),
            TextButton(
              onPressed: () {
                showRemoveUserDialog(context, event: event, member: member);
              },
              child: const Text(
                'Remove Member',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ));
  }
}
