// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/support/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PurchasesService.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Scheduled notifications for daily reminders to complete the survey.',
        locked: false,
        importance: NotificationImportance.Default,
      ),
    ],
  );

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({
    Key? key,
    required this.prefs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<AppUser?>.value(
        value: AuthService().appUserStream,
        initialData: null,
      ),
      ChangeNotifierProvider<SettingsNotifier>(
        create: (_) => SettingsNotifier(
          darkMode: prefs.getBool('darkMode') ?? true,
          notificationsAllowed: prefs.getBool('notificationsAllowed') ?? true,
          notificationHours: prefs.getInt('notificationHours') ?? 7,
          notificationMins: prefs.getInt('notificationMins') ?? 0,
        ),
      ),
      ChangeNotifierProvider<UserNotifier>(
        create: (_) => UserNotifier(FirebaseAuth.instance.currentUser),
      ),
      ChangeNotifierProvider<EventNotifier>(
        create: (_) => EventNotifier(),
      ),
      ChangeNotifierProvider<ResponseNotifier>(
        create: (_) => ResponseNotifier(),
      ),
      ChangeNotifierProvider<RevenueCatNotifier>(
        create: (_) => RevenueCatNotifier(),
      ),
    ], child: const App());
  }
}
