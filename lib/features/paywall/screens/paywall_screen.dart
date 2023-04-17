import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellness_tracker/features/home/widgets/document_dialog.dart';
import 'package:wellness_tracker/features/paywall/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context);
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By subscribing to the Pro membership, you are agreeing to our ",
                    style: Theme.of(context).textTheme.headline6,
                    children: [
                      TextSpan(
                        text: "Terms & Conditions ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse('https://doc-hosting.flycricket.io/athle-sense-terms-of-use/846f33fe-2bec-4351-abd9-ad56cec16281/terms'));
                          },
                      ),
                      TextSpan(
                        text: "and ",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse('https://doc-hosting.flycricket.io/athle-sense-privacy-policy/de548fc4-3440-4bf8-a998-bd8dd0d360b2/privacy'));
                          },
                      ),
                      TextSpan(
                        text: ".",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
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
      ),
    );
  }
}

// patHrl