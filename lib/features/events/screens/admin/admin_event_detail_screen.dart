// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/auth_service.dart';
import 'package:wellness_tracker/services/event_service.dart';
import 'package:wellness_tracker/support/wrapper.dart';

class AdminEventDetailScreen extends StatefulWidget {
  const AdminEventDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminEventDetailScreen> createState() => _AdminEventDetailScreenState();
}

class _AdminEventDetailScreenState extends State<AdminEventDetailScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    await EventService.readMembersInEvent(context, event: eventNotifier.currentEvent!);
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Event event = eventNotifier.currentEvent!;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            event.name,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          centerTitle: false,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert_rounded),
              onSelected: (value) async {
                if (value == AdminEventMenuItems.item1) {
                  showShareEventDialog(context, code: event.shareId);
                } else if (value == AdminEventMenuItems.item2) {
                  // Navigator to members list
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MembersListScreen()));
                } else if (value == AdminEventMenuItems.item3) {
                  if (event.creator == AuthService.currentUserId!) {
                    // Delete
                    showDeleteEventDialog(context, event: event);
                  } else {
                    // Leave
                    showLeaveEventDialog(context, event: event);
                  }
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: AdminEventMenuItems.item1,
                  child: Text('Share'),
                ),
                const PopupMenuItem(
                  value: AdminEventMenuItems.item2,
                  child: Text('Members'),
                ),
                PopupMenuItem(
                  value: AdminEventMenuItems.item3,
                  child: Text(event.creator == AuthService.currentUserId! ? 'Delete' : 'Leave'),
                ),
              ],
            )
          ],
        ),
        body: const OverviewTab());
  }
}

enum AdminEventMenuItems {
  item1,
  item2,
  item3;
}
