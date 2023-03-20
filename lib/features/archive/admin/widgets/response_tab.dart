import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/archive/admin/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:intl/intl.dart';

class ResponseTab extends StatefulWidget {
  const ResponseTab({Key? key}) : super(key: key);

  @override
  State<ResponseTab> createState() => _ResponseTabState();
}

class _ResponseTabState extends State<ResponseTab> {
  late PageController _pageController = PageController();
  int activeIndex = 0;

  List<Widget> _buildPages(ResponseNotifier responseNotifier) {
    List<Widget> _pageList = [];
    for (var i = 0; i < responseNotifier.responseEachDay!.length; i++) {
      _pageList.add(ResponseListView(dayIndex: i));
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
        Text(
          displayDate,
          style: Theme.of(context).textTheme.headline5,
        ),
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
    return responseNotifier.responseEachDay == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : responseNotifier.responseEachDay![0].isEmpty
            ? const Center(child: Text('No Responses yet'))
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
              );
  }
}
