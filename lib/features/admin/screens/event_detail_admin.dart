import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/members_tab.dart';
import 'package:reading_wucc/features/admin/widgets/questions_tab.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';

class EventDetailAdmin extends StatefulWidget {
  const EventDetailAdmin({Key? key}) : super(key: key);

  @override
  State<EventDetailAdmin> createState() => _EventDetailAdminState();
}

class _EventDetailAdminState extends State<EventDetailAdmin> {
  int _tabIndex = 0;
  PageController _pageController = PageController();
  List<Widget> screens = const [ResponseTab(), QuestionsTab(), MembersTab(), DailyResponseTab()];

  @override
  void initState() {
    super.initState();

    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);

    _refresh(userNotifier, eventNotifier, responseNotifier);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh(UserNotifier userNotifier, EventNotifier eventNotifier, ResponseNotifier responseNotifier) async {
    await EventDatabase.readEventMembers(eventNotifier);
    await ResponseDatabase.readEventResponses(responseNotifier, eventNotifier.currentEvent!.uid!);
    await ResponseDatabase.readMemberResponses(responseNotifier, eventNotifier.currentEvent!.uid!, userNotifier.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
            _tabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.question_answer_outlined), label: 'Responses'),
          BottomNavigationBarItem(icon: Icon(Icons.question_mark_outlined), label: 'Questions'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Members'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined), label: 'Your Question'),
        ],
      ),
    );
  }
}
