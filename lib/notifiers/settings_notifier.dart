import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness_tracker/services/notification_service.dart';

class SettingsNotifier extends ChangeNotifier {
  late SharedPreferences prefs;
  late bool _darkMode;
  late bool _askedNotifications;
  late bool _notificationsAllowed;
  late int _notificationHours;
  late int _notificationMins;

  SettingsNotifier({required bool darkMode, required bool askedNotifications, required bool notificationsAllowed, required int notificationHours, required int notificationMins}) {
    _darkMode = darkMode;
    _askedNotifications = askedNotifications;
    _notificationsAllowed = notificationsAllowed;
    _notificationHours = notificationHours;
    _notificationMins = notificationMins;
  }

  bool get darkMode => _darkMode;
  bool get notificationsAllowed => _notificationsAllowed;
  bool get askedNotifications => _askedNotifications;
  int get notificationHours => _notificationHours;
  int get notificationMins => _notificationMins;

  Future<void> setDarkMode(bool darkMode) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode);
    _darkMode = darkMode;
    notifyListeners();
  }

  Future<void> setAskedNotifications(bool askedNotifications) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('askedNotifications', askedNotifications);
    _askedNotifications = askedNotifications;
    notifyListeners();
  }

  Future<void> setNotificationsAllowed(bool notificationsAllowed) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsAllowed', notificationsAllowed);
    _notificationsAllowed = notificationsAllowed;
    notifyListeners();
  }

  Future<void> setNotificationsTime({required int notificationHours, required int notificationMins}) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notificationHours', notificationHours);
    await prefs.setInt('notificationMins', notificationMins);
    _notificationHours = notificationHours;
    _notificationMins = notificationMins;
    notifyListeners();
  }
}
