import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/services/auth_service.dart';

class UserNotifier extends ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  set setCurrentUser(AppUser? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
}
