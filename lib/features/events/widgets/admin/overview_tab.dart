import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';

class OverviewTab extends StatelessWidget {
  OverviewTab({super.key});
  PageController tabContainerController = PageController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SummaryRow(
              pageController: tabContainerController,
              scrollController: scrollController,
            ),
            TeamRadarChart(),
            TabContainer(
              pageController: tabContainerController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('See All Responses'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
