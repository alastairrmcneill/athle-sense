import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_wucc/features/home/services/event_service.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

// 1 button Dialog
showAddEventDialogBox(BuildContext context, UserNotifier userNotifier, EventNotifier eventNotifier) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _code = '';
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Enter event code',
        ),
        maxLines: 1,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
        },
        onSaved: (value) {
          _code = value!.trim();
        },
      ),
    );
  }

  Dialog alert = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: [
              Text('Share this code with your team.'),
              const SizedBox(height: 10.0),
              _buildForm(),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  TextButton(
                    child: Text(
                      'Cancel',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Join',
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      String snackBarText = '';
                      String result = await addEventToUser(userNotifier, eventNotifier, _code);

                      if (result == '') {
                        snackBarText = 'Unsuccesful';
                      } else {
                        snackBarText = result;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            snackBarText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          )));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
