import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_wucc/models/models.dart';

// 1 button Dialog
showShareCodDialog({required BuildContext context, required Event event}) {
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
              Text(event.shareId),
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
                      'Copy',
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: event.shareId));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Group code copied to clipboard",
                        textAlign: TextAlign.center,
                      )));
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
