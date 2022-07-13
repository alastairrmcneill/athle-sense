import 'package:flutter/material.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/support/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MemberWellnessGraphs extends StatefulWidget {
  const MemberWellnessGraphs({Key? key}) : super(key: key);

  @override
  State<MemberWellnessGraphs> createState() => _MemberWellnessGraphsState();
}

class _MemberWellnessGraphsState extends State<MemberWellnessGraphs> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      height: 250,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              children: const [
                MemberWellnessRadar(),
                MemberWellnessLineGraph(),
              ],
            ),
          ),
          AnimatedSmoothIndicator(
            activeIndex: _pageIndex,
            count: 2,
            effect: WormEffect(
              activeDotColor: Colors.teal,
              dotColor: MyColors.darkTextColor!,
              dotHeight: 6,
              dotWidth: 6,
            ),
          )
        ],
      ),
    );
  }
}
