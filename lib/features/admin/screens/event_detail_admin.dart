import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';

class EventDetailAdmin extends StatefulWidget {
  const EventDetailAdmin({Key? key}) : super(key: key);

  @override
  State<EventDetailAdmin> createState() => _EventDetailAdminState();
}

class _EventDetailAdminState extends State<EventDetailAdmin> {
  late PageController _pageController = PageController();
  int activeIndex = 0;

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

  List<Widget> _buildPages(ResponseNotifier responseNotifier) {
    List<Widget> _pageList = [];
    for (var i = 0; i < responseNotifier.responseEachDay!.length; i++) {
      _pageList.add(MemberListView(dayIndex: i));
    }

    return _pageList;
  }

  Widget _buildButtons(ResponseNotifier responseNotifier) {
    DateTime dateTime = responseNotifier.responseEachDay![activeIndex][0].date;
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
          onPressed: activeIndex == responseNotifier.responseEachDay!.length - 1
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
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: responseNotifier.responseEachDay == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                WellnessChart(),
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
            ),
    );
  }
}
