import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wellness_tracker/features/onboarding/screens/screens.dart';
import 'package:wellness_tracker/support/wrapper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  bool isLastPage = false;
  List<Widget> pages = const [
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == pages.length - 1;
          });
        },
        children: pages,
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Wrapper()));
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: const Size.fromHeight(80),
              ),
              child: const Text('Get Started'),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        pageController.animateToPage(pages.length - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                      child: const Text('Skip')),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: pages.length,
                    effect: WormEffect(dotHeight: 6, dotWidth: 6, activeDotColor: Theme.of(context).textSelectionTheme.cursorColor!),
                  ),
                  TextButton(
                      onPressed: () {
                        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                      child: const Text('Next')),
                ],
              ),
            ),
    );
  }
}
