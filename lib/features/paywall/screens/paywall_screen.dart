import 'package:flutter/material.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:wellness_tracker/features/paywall/widgets/widgets.dart';
import 'package:wellness_tracker/support/theme.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: MyColors.darkCardColor,
              ),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                children: const [
                  SubscriptionOptionsTable(),
                  SizedBox(height: 10),
                  OfferingText(),
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
    );
  }
}
