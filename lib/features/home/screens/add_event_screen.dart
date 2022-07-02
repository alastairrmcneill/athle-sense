import 'package:flutter/material.dart';
import 'package:reading_wucc/features/home/widgets/new_event_form.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NewEventForm(),
    );
  }
}
