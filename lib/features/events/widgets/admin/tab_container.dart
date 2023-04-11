// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';
import 'package:wellness_tracker/support/theme.dart';

class TabContainer extends StatefulWidget {
  final PageController pageController;
  const TabContainer({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  List<String> options = ['Availability', 'Daily Drops', 'To Baseline', 'Incomplete'];
  List<bool> selected = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: SizedBox(
        height: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: PageView(
                    controller: widget.pageController,
                    children: const [
                      BaselineTab(),
                      YesterdayTab(),
                      IncompleteTab(),
                      AvailabilityTab(),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: widget.pageController,
                  count: 4,
                  onDotClicked: (index) {
                    widget.pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
                  },
                  effect: WormEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: Theme.of(context).textSelectionTheme.cursorColor!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
