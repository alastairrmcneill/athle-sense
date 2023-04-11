// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/onboarding/screens/screens.dart';

import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';
import 'package:wellness_tracker/support/wrapper.dart';

class App extends StatelessWidget {
  final bool showHome;
  const App({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settingsNotifier.darkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      home: showHome ? const Wrapper() : const OnboardingScreen(),
    );
  }
}
