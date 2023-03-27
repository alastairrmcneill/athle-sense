// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/event_service.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            event.name,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          centerTitle: false,
          bottom: const TabBar(
            labelPadding: EdgeInsets.only(bottom: 10, top: 10),
            tabs: [
              Text('Overview'),
              Text('Members'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [OverviewTab(), MembersTab()],
        ),
      ),
    );
  }
}
