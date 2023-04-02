import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class OfferingText extends StatelessWidget {
  const OfferingText({super.key});

  @override
  Widget build(BuildContext context) {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context);
    return Text(
      'Pro - ${revenueCatNotifier.currentOffering!.availablePackages.first.storeProduct.priceString}/month',
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
