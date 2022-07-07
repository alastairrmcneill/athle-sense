import 'package:flutter/material.dart';
import 'package:reading_wucc/features/member/widgets/widgets.dart';

class EventDetailMember extends StatefulWidget {
  const EventDetailMember({Key? key}) : super(key: key);

  @override
  State<EventDetailMember> createState() => _EventDetailMemberState();
}

class _EventDetailMemberState extends State<EventDetailMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Page'),
      ),
      body: DailyResponseForm(),
    );
  }
}
