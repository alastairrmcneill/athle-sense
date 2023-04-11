import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

showAddEventDialog(BuildContext context) {
  UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
  EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
  SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String code = '';

  Widget buildTitle() {
    return Text(
      'Join an existing group.',
      style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24, fontWeight: FontWeight.w300),
      textAlign: TextAlign.center,
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Enter group code',
        ),
        style: Theme.of(context).textTheme.headline5,
        maxLines: 1,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
        },
        onSaved: (value) {
          code = value!.trim();
        },
      ),
    );
  }

  Future submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    await EventService.joinEvent(context, code: code);

    Navigator.of(context).pop();
  }

  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 10.0),
          buildForm(),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(
                'Join',
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
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
