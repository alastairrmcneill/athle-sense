import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

showAddEventDialog(BuildContext context) {
  UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
  EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String code = '';

  Widget buildTitle() {
    return Text(
      'Join an existing event.',
      style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24, fontWeight: FontWeight.w300),
      textAlign: TextAlign.center,
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Enter event code',
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

    String snackBarText = '';
    bool result = await EventService.joinEvent(context, code: code);

    if (result) {
      snackBarText = 'Joined event successfully';
    } else {
      snackBarText = 'Unsuccessful, please try again';
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
  }

  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    backgroundColor: MyColors.cardColor,
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
              child: Text(
                'Join',
                style: Theme.of(context).textTheme.headline5!.copyWith(color: MyColors.lightTextColor),
              ),
              onPressed: () async {
                await submit(context);
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(MyColors.backgroundColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.headline5,
              ),
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
