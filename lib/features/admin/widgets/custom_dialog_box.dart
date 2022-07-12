import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/support/theme.dart';

// 1 button Dialog
showShareCodDialog({required BuildContext context, required Event event}) {
  Dialog alert = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: 200.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Share this code with your team.'),
              const SizedBox(height: 10.0),
              Text(event.shareId),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Copy',
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: MyColors.backgroundColor),
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: event.shareId));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Group code copied to clipboard",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[300])),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
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
