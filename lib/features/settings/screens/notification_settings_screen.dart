import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/notification_service.dart';
import 'package:wellness_tracker/support/theme.dart';
import 'package:intl/intl.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    DateTime now = DateTime.now();
    DateTime time = DateTime(now.year, now.month, now.day, settingsNotifier.notificationHours, settingsNotifier.notificationMins);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifcation settings',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Allow notifications',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: Switch(
                onChanged: (value) {
                  settingsNotifier.setNotificationsAllowed(value);
                  NotificationService.createScheduledNotification(context);
                },
                value: settingsNotifier.notificationsAllowed,
              ),
              onTap: () {},
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              color: MyColors.lightTextColor!.withOpacity(0.8),
            ),
            ListTile(
              title: Text(
                'Notification time',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: Text(
                DateFormat('HH:mm').format(time),
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: settingsNotifier.notificationHours,
                    minute: settingsNotifier.notificationMins,
                  ),
                );

                if (newTime == null) return;

                settingsNotifier.setNotificationsTime(
                  notificationHours: newTime.hour,
                  notificationMins: newTime.minute,
                );
                NotificationService.createScheduledNotification(context);
              },
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              color: MyColors.lightTextColor!.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
