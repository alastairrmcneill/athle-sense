import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/events/screens/screens.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class OverviewTab extends StatefulWidget {
  OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  PageController tabContainerController = PageController();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AllTeamResponses()));
                  },
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
