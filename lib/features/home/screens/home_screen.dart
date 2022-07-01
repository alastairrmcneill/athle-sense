import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/auth_service.dart';
import 'package:reading_wucc/services/event_database.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: ElevatedButton(
        onPressed: () async {
          await EventDatabase.createEvent(
            Event(
              name: 'Reading @ WUCC',
              admins: [userNotifier.currentUser!.uid],
              members: [],
            ),
          );
        },
        child: Text('Create Event'),
      ),
    );
  }
}
