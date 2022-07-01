import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/event_database.dart';
import 'package:reading_wucc/services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    UserDatabase.getCurrentUser(userNotifier);
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(userNotifier.currentUser!.name),
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
              admins: [userNotifier.currentUser!.name],
              members: [],
            ),
          );
        },
        child: Text('Create Event'),
      ),
    );
  }
}
