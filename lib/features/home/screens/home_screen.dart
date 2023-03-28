import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:wellness_tracker/features/history/screens/screens.dart';
import 'package:wellness_tracker/features/settings/widgets/widgets.dart';
import 'package:wellness_tracker/features/today/screens/screens.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/response_service.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/support/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int tabIndex = 2;
  @override
  void initState() {
    super.initState();

    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);

    UserDatabase.getCurrentUser(userNotifier);
    ResponseService.loadUserResponses(context);
    EventService.loadUserEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);

    List<Widget> tabs = const [TodayScreen(), HisotryScreen(), EventsScreen()];

    return Scaffold(
      appBar: AppBar(
        title: userNotifier.currentUser == null ? const Text('Hi!') : Text('Hi ${userNotifier.currentUser!.name} 👋'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: Scaffold.of(context).openEndDrawer,
              icon: const Icon(Icons.settings_outlined),
            ),
          ),
        ],
      ),
      endDrawer: CustomRightDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (value) {
          setState(() {
            tabIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Events',
          ),
        ],
      ),
      body: tabs[tabIndex],
    );
  }
}
