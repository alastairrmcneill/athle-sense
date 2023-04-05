import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

showShareEventDialog(BuildContext context, {required String code}) {
  SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);
  Dialog dialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Share this code with others.',
            style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            code,
            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18, fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(
                'Copy',
              ),
              onPressed: () async {
                Clipboard.setData(ClipboardData(text: code));
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

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
