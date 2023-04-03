import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatNotifier extends ChangeNotifier {
  RevenueCatNotifier() {
    init();
  }

  bool _proAccess = false;
  Offering? _currentOffering;

  bool get proAccess => _proAccess;
  Offering? get currentOffering => _currentOffering;

  Future init() async {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      updatePurchaserInfo();
    });
  }

  Future updatePurchaserInfo() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();

      if (customerInfo.entitlements.all['Pro'] == null) {
        _proAccess = false;
      } else {
        if (customerInfo.entitlements.all['Pro']!.isActive) {
          // Grant user "pro" access
          _proAccess = true;
        }
      }
    } on PlatformException catch (e) {
      // Error fetching purchaser info
      _proAccess = false;
    }

    notifyListeners();
  }

  set setCurrentOffering(Offering? currentOffering) {
    _currentOffering = currentOffering;
    notifyListeners();
  }
}
