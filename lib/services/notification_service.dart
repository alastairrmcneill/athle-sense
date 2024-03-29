import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

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
      debug: false,
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) async {},
      onDismissActionReceivedMethod: (receivedAction) async {},
      onNotificationCreatedMethod: (receivedNotification) async {},
      onNotificationDisplayedMethod: (receivedNotification) async {},
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
      if (isAllowed && settingsNotifier.notificationsAllowed) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: Random().nextInt(20000000),
            channelKey: channelKey,
            title: 'Don\'t forget to review your day!',
            body: 'Respond to the daily survey and so you can get valuable wellness insights!',
            notificationLayout: NotificationLayout.Default,
            color: MyColors.lightAccentColor,
          ),
          schedule: NotificationCalendar(
            repeats: true,
            hour: settingsNotifier.notificationHours,
            // hour: 8,
            minute: settingsNotifier.notificationMins,
            // minute: 38,
            second: 0,
            millisecond: 0,
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          ),
        );
      }
    });
  }
}
