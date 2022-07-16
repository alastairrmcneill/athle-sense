import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/home/services/event_service.dart';
import 'package:reading_wucc/features/member/widgets/custom_dialog_box.dart';
import 'package:reading_wucc/features/member/widgets/widgets.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';
import 'package:reading_wucc/support/theme.dart';

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
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(eventNotifier.currentEvent!.name),
        actions: [
          TextButton(
            onPressed: () async {
              await showConfirmLeaveEventDialog(
                context: context,
                eventNotifier: eventNotifier,
                userNotifier: userNotifier,
                responseNotifier: responseNotifier,
              );
            },
            child: Text(
              'Leave',
              style: Theme.of(context).textTheme.headline5!.copyWith(color: MyColors.darkRedColor),
            ),
          ),
        ],
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
