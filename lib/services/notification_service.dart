import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class NotificationService {
  static Future createScheduledNotification(BuildContext context) async {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);

    await AwesomeNotifications().cancelAllSchedules();
    if (settingsNotifier.notificationsAllowed) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'scheduled_channel',
          title: 'Don\'t forget to review your day!',
          body: 'Respond to the daily survey and so you can get valuable wellness insights!',
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar(
          repeats: true,
          hour: 15,
          minute: 21,
          second: 0,
          millisecond: 0,
          timeZone: 'UTC',
        ),
      );
    }
  }
}
