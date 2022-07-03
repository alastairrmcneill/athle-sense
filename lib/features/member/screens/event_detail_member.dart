import 'package:flutter/material.dart';

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
    );
  }
}
