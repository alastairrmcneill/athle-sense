import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/features/member/widgets/widgets.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/response_database.dart';
import 'package:intl/intl.dart';

class PreviousResponsesTab extends StatefulWidget {
  const PreviousResponsesTab({Key? key}) : super(key: key);

  @override
  State<PreviousResponsesTab> createState() => _PreviousResponsesTabState();
}

class _PreviousResponsesTabState extends State<PreviousResponsesTab> {
  @override
  void initState() {
    super.initState();

    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    ResponseDatabase.readMemberResponses(responseNotifier, eventNotifier.currentEvent!.uid!, userNotifier.currentUser!.uid);
  }

  late PageController _pageController = PageController();
  int activeIndex = 0;

  List<Widget> _buildPages(ResponseNotifier responseNotifier) {
    List<Widget> _pageList = [];
    for (var i = 0; i < responseNotifier.myResponses!.length; i++) {
      _pageList.add(WellnessGridView(day: i));
    }

    return _pageList;
  }

  Widget _buildButtons(ResponseNotifier responseNotifier) {
    DateTime dateTime = responseNotifier.myResponses![activeIndex].date;
    String displayDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: activeIndex == 0
              ? null
              : () {
                  _pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                },
          icon: Icon(Icons.chevron_left_rounded),
        ),
        Text(displayDate),
        IconButton(
          onPressed: activeIndex == responseNotifier.myResponses!.length - 1
              ? null
              : () {
                  _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                },
          icon: Icon(Icons.chevron_right_rounded),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    return responseNotifier.allResponsesForMember == null
        ? const Center(child: CircularProgressIndicator())
        : responseNotifier.allResponsesForMember!.isEmpty
            ? const Center(child: Text('No responses yet'))
            : Column(
                children: [
                  const MemberWellnessLineGraph(),
                  _buildButtons(responseNotifier),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      physics: const ClampingScrollPhysics(),
                      children: _buildPages(responseNotifier),
                    ),
                  ),
                ],
              );
  }
}
