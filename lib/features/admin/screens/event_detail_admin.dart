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
  List<Widget> screens = const [ResponseTab(), QuestionsTab(), MembersTab()];

  @override
  void initState() {
    super.initState();

    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
    _refresh(eventNotifier, responseNotifier);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh(EventNotifier eventNotifier, ResponseNotifier responseNotifier) async {
    await EventDatabase.readEventMembers(eventNotifier);
    await ResponseDatabase.readEventResponses(responseNotifier, eventNotifier.currentEvent!.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: screens[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.question_answer_outlined), label: 'Responses'),
          BottomNavigationBarItem(icon: Icon(Icons.question_mark_outlined), label: 'Questions'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Members'),
        ],
      ),
    );
  }
}
