import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:wellness_tracker/features/paywall/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: PurchaseButton(),
            ),
          ],
        ),
      ),
    );
  }
}

// patHrl