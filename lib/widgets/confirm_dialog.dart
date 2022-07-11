import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/event_database.dart';

// 1 button Dialog
showConfirmDeleteDialog({required BuildContext context, required EventNotifier eventNotifier}) {
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          Text('Are you sure?'),
          ElevatedButton(
              onPressed: () {
                EventDatabase.deleteEvent(eventNotifier);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Delete')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'))
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
