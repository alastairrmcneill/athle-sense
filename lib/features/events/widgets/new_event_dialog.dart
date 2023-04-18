import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

showNewEventDialog(BuildContext context, {Event? event}) {
  UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
  EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
  SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _pickedStartDate;
  DateTime? _endDate;
  DateTime? _pickedEndDate;

  if (event != null) {
    _nameController.text = event.name;
    _startDateController.text = DateFormat('dd/MM/yyyy').format(event.startDate);
    _endDateController.text = DateFormat('dd/MM/yyyy').format(event.endDate);
    _startDate = event.startDate;
    _pickedStartDate = event.startDate;
    _endDate = event.endDate;
    _pickedEndDate = event.endDate;
  }

  Widget _buildStartDatePicker(BuildContext context, Function setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _startDateController,
        style: Theme.of(context).textTheme.headline5,
        decoration: const InputDecoration(
          hintText: 'Group Start Date',
        ),
        readOnly: true,
        onTap: () async {
          _pickedStartDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Theme.of(context).textTheme.headline6!.color!, // header background color
                    onPrimary: Theme.of(context).scaffoldBackgroundColor, // header text color
                    onSurface: Theme.of(context).textTheme.headline6!.color!, // body text color
                  ),
                ),
                child: child!,
              );
            },
          );

          if (_pickedStartDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(_pickedStartDate!);

            setState(() {
              _startDateController.text = formattedDate;
              _startDate = _pickedStartDate!;
            });
          }
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }

          if (_startDate != null && _endDate != null) {
            if (!_startDate!.isBefore(_endDate!)) {
              return 'Start date must be before end date';
            }
          }
        },
      ),
    );
  }

  Widget _buildEndDatePicker(BuildContext context, Function setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _endDateController,
        style: Theme.of(context).textTheme.headline5,
        decoration: const InputDecoration(
          hintText: 'Group End Date',
        ),
        readOnly: true,
        onTap: () async {
          _pickedEndDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Theme.of(context).textTheme.headline6!.color!, // header background color
                    onPrimary: Theme.of(context).scaffoldBackgroundColor, // header text color
                    onSurface: Theme.of(context).textTheme.headline6!.color!, // body text color
                  ),
                ),
                child: child!,
              );
            },
          );

          if (_pickedEndDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(_pickedEndDate!);

            setState(() {
              _endDateController.text = formattedDate;
              _endDate = _pickedEndDate!;
            });
          }
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }

          if (_startDate != null && _endDate != null) {
            if (!_endDate!.isAfter(_startDate!)) {
              return 'End date must be after start date';
            }
          }
        },
      ),
    );
  }

  Future submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (event == null) {
      await EventService.create(context, name: _nameController.text.trim(), startDate: _startDate!, endDate: _endDate!);
    } else {
      await EventService.update(context, event: event, name: _nameController.text.trim(), startDate: _startDate!, endDate: _endDate!);
    }
    Navigator.of(context).pop();
  }

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event == null ? 'Create a new group.' : 'Edit group.',
                      style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _nameController,
                        style: Theme.of(context).textTheme.headline5,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                        },
                        onSaved: (value) {
                          _nameController.text = value!;
                        },
                      ),
                    ),
                    _buildStartDatePicker(context, setState),
                    _buildEndDatePicker(context, setState),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          event == null ? 'Create' : 'Update',
                        ),
                        onPressed: () async {
                          await submit(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                            settingsNotifier.darkMode ? MyColors.darkCardColor : Colors.grey,
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          ;
        },
      );
    },
  );
}
