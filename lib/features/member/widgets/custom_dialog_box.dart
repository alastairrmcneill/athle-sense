import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_wucc/features/home/services/event_service.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';
import 'package:reading_wucc/support/theme.dart';

// 1 button Dialog
showConfirmLeaveEventDialog({required BuildContext context, required EventNotifier eventNotifier, required UserNotifier userNotifier, required ResponseNotifier responseNotifier}) {
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      width: 200.0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to leave?',
            style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.red)),
              onPressed: () async {
                await leaveEvent(userNotifier, eventNotifier, responseNotifier);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Leave',
                style: Theme.of(context).textTheme.headline5!.copyWith(color: MyColors.backgroundColor),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[300])),
              onPressed: () {
                Navigator.pop(context);
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
