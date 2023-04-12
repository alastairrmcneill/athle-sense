import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wellness_tracker/constants.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class PurchasesService {
  static Future init() async {
    if (Platform.isAndroid) {
      await Purchases.configure(PurchasesConfiguration(revenueCatGoogleAPI));
    } else if (Platform.isIOS) {
      await Purchases.configure(PurchasesConfiguration(revenueCatAppleAPI));
    }
  }

  static Future login(BuildContext context, {required String userID}) async {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context, listen: false);
    await Purchases.logIn(userID);

    // add listener in here

    revenueCatNotifier.updatePurchaserInfo();
  }

  static Future logout(BuildContext context) async {
    await Purchases.logOut();
  }

  static Future fetchOffer(context) async {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context, listen: false);
    try {
      final offerings = await Purchases.getOfferings();
      final currentOffer = offerings.current;

      revenueCatNotifier.setCurrentOffering = currentOffer;
    } on Exception catch (e) {
      revenueCatNotifier.setCurrentOffering = null;
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);

      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
