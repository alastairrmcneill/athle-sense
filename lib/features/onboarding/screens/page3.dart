import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/onboarding/screens/screens.dart';
import 'package:wellness_tracker/services/purchases_service.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () async {
                  await PurchasesService.fetchOffer(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingPaywallScreen()));
                },
                child: Text('Learn More'),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Image.asset(
              'assets/page_3.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
