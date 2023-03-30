// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wellness_tracker/features/events/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class SummaryRow extends StatelessWidget {
  final PageController pageController;
  final ScrollController scrollController;
  const SummaryRow({
    Key? key,
    required this.pageController,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    EventData eventData = eventNotifier.currentEventData!;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SummaryTile(
            title: 'To Baseline',
            content: (eventData.teamWellnessToday - eventData.teamWellnessBaseline).toStringAsFixed(1),
            onTap: () {
              pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.ease);
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 400), curve: Curves.ease);
            },
          ),
          SummaryTile(
            title: 'Yesterday',
            content: (eventData.teamWellnessToday - eventData.teamWellnessYesterday).toStringAsFixed(1),
            onTap: () {
              pageController.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.ease);

              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 400), curve: Curves.ease);
            },
          ),
          SummaryTile(
            title: 'Responses',
            content: (eventData.incompleteMemberIDs.length).toString(),
            onTap: () {
              pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.ease);
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 400), curve: Curves.ease);
            },
          ),
          SummaryTile(
            title: 'Availability',
            content: (eventData.reducedAvailabilityMemberIDs.length).toString(),
            onTap: () {
              pageController.animateToPage(3, duration: Duration(milliseconds: 200), curve: Curves.ease);
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 400), curve: Curves.ease);
            },
          ),
        ],
      ),
    );
  }
}
