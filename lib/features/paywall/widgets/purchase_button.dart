import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/features/paywall/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/purchases_service.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          bool result = await PurchasesService.purchasePackage(revenueCatNotifier.currentOffering!.availablePackages.first);
          if (result) {
            showSnackBar(context, 'Congratulation! You have upgraded your account');
            Navigator.pop(context);
          }
        },
        child: Text('Get Pro'),
      ),
    );
  }
}
