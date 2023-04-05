import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class ChangeThemeScreen extends StatelessWidget {
  const ChangeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Theme',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Light Theme',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: settingsNotifier.darkMode ? const SizedBox() : Icon(Icons.check, color: Theme.of(context).textTheme.headline6!.color!),
              onTap: () {
                if (settingsNotifier.darkMode) {
                  settingsNotifier.setDarkMode(false);
                }
              },
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              title: Text(
                'Dark Theme',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: settingsNotifier.darkMode
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).textTheme.headline6!.color!,
                    )
                  : const SizedBox(),
              onTap: () {
                if (!settingsNotifier.darkMode) {
                  settingsNotifier.setDarkMode(true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
