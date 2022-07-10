import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/member/widgets/widgets.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';

class EventDetailMember extends StatefulWidget {
  const EventDetailMember({Key? key}) : super(key: key);

  @override
  State<EventDetailMember> createState() => _EventDetailMemberState();
}

class _EventDetailMemberState extends State<EventDetailMember> {
  PageController _pageController = PageController();
  List<Widget> screens = [DailyResponseTab(), PreviousResponsesTab()];
  int _tabIndex = 0;
  @override
  void initState() {
    super.initState();

    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    ResponseDatabase.readMemberResponses(responseNotifier, eventNotifier.currentEvent!.uid!, userNotifier.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Member Page'),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.question_mark_outlined), label: 'Today'),
          BottomNavigationBarItem(icon: Icon(Icons.question_answer_outlined), label: 'Previous Responses'),
        ],
      ),
    );
  }
}
