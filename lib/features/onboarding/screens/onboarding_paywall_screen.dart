import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness_tracker/features/paywall/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';
import 'package:wellness_tracker/support/wrapper.dart';

class OnboardingPaywallScreen extends StatelessWidget {
  const OnboardingPaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context);
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                'Boost your team\'s performance by managing group wellness metrics with the Pro subscription!',
                style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w200, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: SizedBox(height: 220, child: Image.asset(settingsNotifier.darkMode ? 'assets/event_dark.png' : 'assets/event_light.png')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: const [
                      SubscriptionOptionsTable(),
                      SizedBox(height: 10),
                      OfferingText(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Wrapper()));
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                  },
                  child: const Text('Login to purchase'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// patHrl