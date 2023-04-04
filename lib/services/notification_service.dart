import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class NotificationService {
  static String channelKey = 'scheduled_channel';

  static Future init() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/ic_stat_directions_run',

      // 'resource://drawable-hdpi/ic_stat_directions_run',
      // null,
      [
        NotificationChannel(
          channelKey: channelKey,
          channelName: 'Scheduled Notifications',
          channelDescription: 'Scheduled notifications for daily reminders to complete the survey.',
          locked: false,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      debug: true,
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) async {
        print('onActionReceivedMethod');
      },
      onDismissActionReceivedMethod: (receivedAction) async {
        print('onDismissActionReceivedMethod');
      },
      onNotificationCreatedMethod: (receivedNotification) async {
        print('onNotificationCreatedMethod');
      },
      onNotificationDisplayedMethod: (receivedNotification) async {
        print('onNotificationDisplayedMethod');
      },
    );
  }

  static Future askForNotifications(BuildContext context) async {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);
    if (!settingsNotifier.askedNotifications) {
      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
          settingsNotifier.setAskedNotifications(true);
        }
      });
    }
  }

  static Future createScheduledNotification(BuildContext context) async {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);
    await AwesomeNotifications().cancelAllSchedules();

    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      print('Notifications allowed: $isAllowed');
      print('Notifications allowed in app: ${settingsNotifier.notificationsAllowed}');
      if (isAllowed && settingsNotifier.notificationsAllowed) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: channelKey,
            title: 'Don\'t forget to review your day!',
            body: 'Respond to the daily survey and so you can get valuable wellness insights!',
            notificationLayout: NotificationLayout.Default,
            color: Colors.green,
          ),
          schedule: NotificationCalendar(
            repeats: true,
            hour: 14,
            minute: 54,
            second: 0,
            millisecond: 0,
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          ),
        );
      }
    });
  }
}
