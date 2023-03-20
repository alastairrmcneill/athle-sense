import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/notification_service.dart';
import 'package:wellness_tracker/services/services.dart';

class NewEventForm extends StatefulWidget {
  const NewEventForm({Key? key}) : super(key: key);

  @override
  State<NewEventForm> createState() => _NewEventFormState();
}

class _NewEventFormState extends State<NewEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String _name = '';
  late DateTime _startDate;
  DateTime? _pickedStartDate;
  late DateTime _endDate;
  DateTime? _pickedEndDate;

  String randomString(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  int randomInt() {
    const ch = '1234567890';
    Random r = Random();
    return int.parse(String.fromCharCodes(Iterable.generate(9, (_) => ch.codeUnitAt(r.nextInt(ch.length)))));
  }

  Future _createEvent(UserNotifier userNotifier, EventNotifier eventNotifier) async {
    Event neweEvent = Event(
      name: _name.trim(),
      startDate: _startDate,
      endDate: _endDate,
      admins: [userNotifier.currentUser!.uid],
      members: [],
      shareId: randomString(6),
      notificationId: randomInt(),
    );
    await EventDatabase.createEvent(userNotifier, eventNotifier, neweEvent);
    await createScheduledNotification(id: neweEvent.notificationId, eventName: neweEvent.name);

    Navigator.pop(context);
  }

  Widget _buildNameInput() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Name',
      ),
      maxLines: 1,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildStartDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _startDateController,
        decoration: const InputDecoration(
          labelText: 'Event Start Date',
        ),
        readOnly: true,
        onTap: () async {
          _pickedStartDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (_pickedStartDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(_pickedStartDate!);

            setState(() {
              _startDateController.text = formattedDate;
            });
          }
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
        },
        onSaved: (value) {
          _startDate = DateFormat('dd/MM/yyyy').parse(_startDateController.text);
        },
      ),
    );
  }

  Widget _buildEndDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _endDateController,
        decoration: const InputDecoration(
          labelText: 'Event End Date',
        ),
        readOnly: true,
        onTap: () async {
          _pickedEndDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (_pickedEndDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(_pickedEndDate!);

            setState(() {
              _endDateController.text = formattedDate;
            });
          }
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
        },
        onSaved: (value) {
          _endDate = DateFormat('dd/MM/yyyy').parse(_endDateController.text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNameInput(),
                _buildStartDatePicker(),
                _buildEndDatePicker(),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();

                  _createEvent(userNotifier, eventNotifier);
                },
                child: Text('Save')),
          )
        ],
      ),
    );
  }
}
