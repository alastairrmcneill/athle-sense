import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/paywall/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          showPurchasePackageDialog(context, package: revenueCatNotifier.currentOffering!.availablePackages.first);
        },
        child: Text('Get Pro'),
      ),
    );
  }
}
