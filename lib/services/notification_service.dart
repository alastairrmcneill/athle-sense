import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';

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
      hour: 7,
      minute: 30,
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

Future<void> setScheduledNotifications(List<Event> eventList) async {
  await cancelAllScheduledNotifications();

  await cancelAllScheduledNotifications();
  for (var event in eventList) {
    await createScheduledNotification(id: event.notificationId, eventName: event.name);
  }
}
