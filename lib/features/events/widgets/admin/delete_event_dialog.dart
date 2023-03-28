import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/services/event_service.dart';
import 'package:wellness_tracker/support/theme.dart';

showDeleteEventDialog(BuildContext context, {required Event event}) {
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    backgroundColor: MyColors.cardColor,
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
            'Are you sure you want to delete this event?',
            style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.red)),
              onPressed: () async {
                await EventService.deleteEvent(context, event: event);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.headline5!.copyWith(color: MyColors.backgroundColor),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(MyColors.backgroundColor)),
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
