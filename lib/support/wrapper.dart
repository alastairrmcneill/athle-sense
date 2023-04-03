import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/home/screens/screens.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/authentication/screens/screens.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
