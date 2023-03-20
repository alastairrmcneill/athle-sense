import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/events/widgets/new_event_form.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new event'),
      ),
      body: NewEventForm(),
    );
  }
}
