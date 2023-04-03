import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';
import 'package:wellness_tracker/support/wrapper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settingsNotifier.darkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      home: const Wrapper(),
    );
  }
}
