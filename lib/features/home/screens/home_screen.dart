import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:wellness_tracker/features/history/screens/screens.dart';
import 'package:wellness_tracker/features/settings/widgets/widgets.dart';
import 'package:wellness_tracker/features/today/screens/screens.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/response_service.dart';
import 'package:wellness_tracker/services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late PageController pageController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: tabIndex);
    setup();
  }

  Future setup() async {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    final user = Provider.of<AppUser?>(context, listen: false);

    await UserDatabase.getCurrentUser(context);
    await EventService.loadUserEvents(context);
    await ResponseService.loadUserResponses(context);
    await PurchasesService.login(context, userID: user!.uid);
    await PurchasesService.fetchOffer(context);
    await NotificationService.askForNotifications(context);
    await NotificationService.createScheduledNotification(context);

    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

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
          pageController.animateToPage(
            value,
            duration: Duration(milliseconds: 200),
            curve: Curves.bounceOut,
          );
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
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => setState(() => tabIndex = value),
        children: const [TodayScreen(), HisotryScreen(), EventsScreen()],
      ),
    );
  }
}
