import 'package:flutter/material.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';

class EventDetailAdmin extends StatefulWidget {
  const EventDetailAdmin({Key? key}) : super(key: key);

  @override
  State<EventDetailAdmin> createState() => _EventDetailAdminState();
}

class _EventDetailAdminState extends State<EventDetailAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: MemberListView(),
    );
  }
}
