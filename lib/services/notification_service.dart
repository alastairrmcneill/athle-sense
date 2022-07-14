import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> createScheduledNotification({required int id, required String eventName}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'scheduled_channel',
      title: '$eventName: Submit wellness.',
      body: 'Answer the wellness and availability questions.',
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      repeats: true,
      hour: 13,
      minute: 33,
      second: 0,
      millisecond: 0,
    ),
  );
}

Future<void> cancelAllScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduledNotification(int id) async {
  await AwesomeNotifications().cancelSchedule(id);
}
